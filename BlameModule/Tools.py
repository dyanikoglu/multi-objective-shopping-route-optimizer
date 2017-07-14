from django.core.exceptions import ObjectDoesNotExist
from gisModule import models
from BlameModule import Paramaters as params
from threading import Thread
import time


# Thread decorator
def postpone(func):
    def decorator(*args, **kwargs):
        t = Thread(target=func, args=args, kwargs=kwargs)
        t.daemon = True
        t.start()

    return decorator


def calculate_points(user, retailer):
    # Retailer reputation increases -> Blame Point decreases
    # Blamer user reputation increases -> Blame Point increases
    return (user.reputation / params.REP_REQ_FOR_BLAMING) * (
    params.LOWEST_REP_FOR_RET / (retailer.reputation + params.RET_MIN_REP))


def update_reputation():
    return


def check_reputation(user):
    return user.reputation >= params.REP_REQ_FOR_BLAMING


def duplicate_blame(retailer_product, user):
    try:
        models.Blame.objects.get(user=user, retailer_product=retailer_product)
    except ObjectDoesNotExist:
        return False
    return True


@postpone
def check_product_blame_level(retailer_product, pusher_client):
    if not retailer_product.blame_point >= params.BLAME_POINT_LIMIT_FOR_PROD:
        # No action required
        return

    # Wait a little more
    time.sleep(5)
    # Send notification to each online user ( TODO Change it with random users )
    notification = "You should verify a false price proposal for %s" % retailer_product.__str__()
    for user_id in pusher_client.channels_info()['channels'].keys():
        pusher_client.trigger('%s' % user_id, 'blame_verification_required', {'message': notification})







