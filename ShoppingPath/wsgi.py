"""
WSGI config for ShoppingPath project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application
from gisModule import tasks
from background_task import models as background_models

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "ShoppingPath.settings")

application = get_wsgi_application()

background_models.Task.objects.all().delete()  # DELETE OLD TASKS FROM TABLE

tasks.blame_module_check_blame_status(repeat=30)
tasks.blame_module_check_proposal(repeat=30)
tasks.statistic_module_basic_statistics(repeat=30)

