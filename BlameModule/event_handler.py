from gisModule import models
from BlameModule import tools, parameters
from django.db import transaction
from datetime import datetime
from dateutil.tz import tzlocal


# Creates a new blame record on db
@transaction.atomic  # Guarantee that db process was completely successful
def new_blame(retailer_product, user):
    if tools.duplicate_blame(retailer_product, user):
        return False, "You have already blamed this product"
    if not tools.check_reputation(user):
        return False, "You don't have enough reputation for blaming a product"

    retailer_product.blame_point += tools.calculate_points(user, retailer_product.retailer)

    retailer_product.save()
    models.Blame.objects.create(retailer_product=retailer_product, user=user)

    return True, "Blame successfully created"


# Creates a new false price proposal on db
@transaction.atomic  # Guarantee that db process was completely successful
def new_proposal(retailer_product):
    if tools.check_blame_points(retailer_product):
        # No action required
        return

    if not retailer_product.proposal_ongoing:
        retailer_product.proposal_ongoing = True
        models.FalsePriceProposal.objects.create(retailer=retailer_product.retailer, retailer_product=retailer_product)
        retailer_product.save()


def check_proposal(proposal):
    if proposal.status_code == 0:
        send_proposals(proposal)  # Send first proposals
    elif proposal.status_code == 1:
        check_inactive_sent_proposals_to_users(proposal)  # Delete inactive ones
        send_proposals(proposal)  # Send new ones if inactive ones are removed
        check_complete_responded_proposals(proposal)  # Update status of proposal if eligible
    elif proposal.status_code == 2:
        # TODO Can be connected with admin panel for actual auth. review
        auth_confirm_proposal(proposal) # Auto confirm proposal
    elif proposal.status_code == 3:
        # Do nothing, this proposal is archived
        # TODO Carry these reports into another table for performance in long run
        return


@transaction.atomic
def auth_confirm_proposal(proposal):
    print("%s report is automatically accepted by auth." % proposal.retailer_product.__str__())
    for proposal_sent in models.ProposalSent.objects.filter(false_price_proposal=proposal):
        if proposal_sent.response == True:
            proposal_sent.user.reputation += parameters.PRIZE_FOR_CORRECT_RESPONSE
        else:
            proposal_sent.user.reputation += parameters.PENALTY_FOR_FALSE_RESPONSE
        proposal_sent.user.save()

    # Archive the proposal
    proposal.status_code = 3
    proposal.save()
    proposal.retailer.reputation += parameters.PENALTY_FOR_ACCEPTED_REPORT
    proposal.retailer.save_without_address()
    proposal.retailer_product.removed_from_store = True
    proposal.retailer_product.save()


@transaction.atomic  # Guarantee that db process was completely successful
def send_proposals(proposal):
    tools.propose_to_random_users(proposal, parameters.USER_COUNT_TO_SEND_PROPOSAL - proposal.send_count)
    proposal.status_code = 1  # Proposal is now on review by users
    proposal.save()


@transaction.atomic
def check_inactive_sent_proposals_to_users(proposal):
    current_date = datetime.now(tzlocal())
    for proposal_sent in models.ProposalSent.objects.filter(false_price_proposal=proposal):
        if (current_date - proposal_sent.updated_at).days > parameters.MAX_INACTIVE_DAY_FOR_PROPOSAL:
            print("Proposal of %s was inactive, deleting..." % proposal_sent.user.username)
            proposal_sent.delete()
            proposal.send_count = proposal.send_count - 1
            proposal.save()
            tools.notify_timeout(proposal_sent.user)


# Checks old blame reports, and removes them. Users will be able to report same product after this action.
@transaction.atomic
def remove_old_blame_reports(proposal):
    current_date = datetime.now(tzlocal())
    for blame in models.Blame.objects.all():
        if (current_date - blame.created_at).days > parameters.MAX_INACTIVE_DAY_FOR_PROPOSAL + 1:
            print("Blame of %s is timed out, deleting..." % blame.user.username)
            blame.delete()


@transaction.atomic
def check_complete_responded_proposals(proposal):
    if proposal.answer_count == parameters.USER_COUNT_TO_SEND_PROPOSAL:
        print("Proposal with id:%s is going to be evaluated:" % proposal.id)
        responses = []
        for proposal_sent in models.ProposalSent.objects.filter(false_price_proposal=proposal):
            responses.append(proposal_sent.response)

        if responses.count(True) > int(parameters.USER_COUNT_TO_SEND_PROPOSAL / 2.0):
            print("Accepted by users!")
            # Prizes and penalties will be decided with auth.'s decision
            proposal.status_code = 2  # To be reviewed by Auth.
            proposal.save()
        else:
            print("Rejected by users")
            # Give prizes and penalties:
            for proposal_sent in models.ProposalSent.objects.filter(false_price_proposal=proposal):
                if proposal_sent.response == True:
                    print("%s got a penalty for wrong response" % proposal_sent.user.username)
                    proposal_sent.user.reputation += parameters.PENALTY_FOR_FALSE_RESPONSE
                else:
                    print("%s got a prize for correct response" % proposal_sent.user.username)
                    proposal_sent.user.reputation += parameters.PRIZE_FOR_CORRECT_RESPONSE
                proposal_sent.user.save()

            # Reset status of related retailer product:
            proposal.retailer_product.blame_point = 0
            proposal.retailer_product.proposal_ongoing = False
            proposal.retailer_product.save()

            proposal.status_code = 3  # Rejected by users, archive it
            proposal.save()
