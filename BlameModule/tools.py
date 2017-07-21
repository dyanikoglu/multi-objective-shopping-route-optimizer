from django.core.exceptions import ObjectDoesNotExist
from gisModule import models
from gisModule import tools as internal_tools
from BlameModule import parameters as params
import pusher
from random import shuffle
from django.db import transaction

pusher_client = pusher.Pusher(
    app_id='337846',
    key='ea171f7b30a44f1ebf65',
    secret='fb0b3fed734f0fb38f75',
    cluster='eu',
    ssl=True
)


def calculate_points(user, retailer):
    # Retailer reputation increases -> Blame Point decreases
    # Blamer user reputation increases -> Blame Point increases
    return params.BLAME_MULTIPLIER * (user.reputation / params.USER_REPUTATION_REQ_FOR_BLAMING) * (
        params.INITIAL_REPUTATION_FOR_RETAILER / (retailer.reputation + 0.001)) + 1


def check_reputation(user):
    return user.reputation >= params.USER_REPUTATION_REQ_FOR_BLAMING


def check_blame_points(retailer_product):
    return retailer_product.blame_point < params.BLAME_POINT_LIMIT_FOR_PRODUCT


def duplicate_blame(retailer_product, user):
    try:
        models.Blame.objects.get(user=user, retailer_product=retailer_product)
    except ObjectDoesNotExist:
        return False
    return True


def notify_timeout(user):
    pusher_client.trigger('%s' % user.id, 'proposal_timed_out', {'message': "One of your false price proposals is timed out"})


@transaction.atomic
def propose_to_random_users(proposal, max_count):
    users = internal_tools.get_all_logged_in_users()
    online_user_count = len(users)
    if online_user_count == 0 or max_count == 0:
        print("No online users or maximum proposal count is reached")
        return

    # Remove users already got that proposal
    for proposal_sent in models.ProposalSent.objects.filter(false_price_proposal=proposal):
        if proposal_sent.user in users:
            print("%s already got that proposal, removing him from list" % proposal_sent.user)
            users.remove(proposal_sent.user)

    if online_user_count <= max_count:
        for user in users:
            models.ProposalSent.objects.create(user=user, false_price_proposal=proposal)
            proposal.send_count = proposal.send_count + 1
            print("New proposal sent to %s..." % user.username)
            pusher_client.trigger('%s' % user.id, 'new_proposal', {'message': "You have got a new false price proposal"})
            proposal.save()
    else:
        # Select random USER_COUNT_TO_SEND_PROPOSAL user from online users
        deck = list(range(0, online_user_count - 1))
        for i in range(0, max_count):
            shuffle(deck)
            temp_user = users[deck.pop()]
            models.ProposalSent.objects.create(user=temp_user, false_price_proposal=proposal)
            print("New proposal sent to %s..." % temp_user.username)
            pusher_client.trigger('%s' % temp_user.id, 'new_proposal', {'message': "You have got a new false price proposal"})
            proposal.send_count = proposal.send_count + 1
            proposal.save()
