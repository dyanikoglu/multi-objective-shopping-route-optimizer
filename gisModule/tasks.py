from gisModule import models
from background_task import background
from BlameModule import event_handler as handler
from StatisticsModule import scheduled_tasks as scheduler


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


@background
def statistic_module_basic_statistics():
    print("Calculating statistics for each user")
    scheduler.basic_statistics()
