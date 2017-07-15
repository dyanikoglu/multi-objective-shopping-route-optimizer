from gisModule import models
from background_task import background
from BlameModule import event_handler as handler


@background
def blame_module_check_blame_status():
    print("Checking blame status")
    for retailer_product in models.RetailerProduct.objects.all():
        handler.new_proposal(retailer_product)


@background
def blame_module_check_proposal():
    print("Checking proposal status")
    for proposal in models.FalsePriceProposal.objects.all():
        handler.check_proposal(proposal)
