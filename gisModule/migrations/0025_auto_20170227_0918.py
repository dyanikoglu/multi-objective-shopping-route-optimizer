# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-27 09:18
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0024_auto_20170227_0916'),
    ]

    operations = [
        migrations.AlterField(
            model_name='treeedge',
            name='childNodeID',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='Child', to='gisModule.BaseProduct'),
        ),
    ]
