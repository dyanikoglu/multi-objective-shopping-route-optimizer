# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-04-13 23:11
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0056_userpreferences'),
    ]

    operations = [
        migrations.AddField(
            model_name='userpreferences',
            name='search_radius',
            field=models.PositiveIntegerField(null='True', verbose_name='Search Radius(km)'),
        ),
    ]
