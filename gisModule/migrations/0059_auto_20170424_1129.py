# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-04-24 11:29
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0058_auto_20170413_2320'),
    ]

    operations = [
        migrations.AlterField(
            model_name='retailerproduct',
            name='unitPrice',
            field=models.FloatField(verbose_name='Unit Price(₺)'),
        ),
    ]
