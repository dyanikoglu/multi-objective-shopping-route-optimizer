# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-05-03 12:26
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0060_auto_20170424_2135'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userpreferences',
            name='market_factor',
        ),
    ]
