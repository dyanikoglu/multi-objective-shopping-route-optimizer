# -*- coding: utf-8 -*-
# Generated by Django 1.11b1 on 2017-03-04 00:07
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0050_auto_20170303_2346'),
    ]

    operations = [
        migrations.AddField(
            model_name='shoppinglistitem',
            name='addedBy',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='gisModule.User'),
        ),
    ]
