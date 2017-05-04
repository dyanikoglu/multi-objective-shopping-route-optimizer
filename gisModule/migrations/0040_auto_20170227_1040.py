# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-27 10:40
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0039_auto_20170227_1033'),
    ]

    operations = [
        migrations.AddField(
            model_name='baseproduct',
            name='parentConnectionID',
            field=models.IntegerField(default=None, editable=False, null=True, verbose_name='Parent Connection ID'),
        ),
        migrations.AlterField(
            model_name='shoppinglistitem',
            name='listID',
            field=models.PositiveIntegerField(verbose_name='List Name'),
        ),
        migrations.AlterField(
            model_name='shoppinglistitem',
            name='productID',
            field=models.PositiveIntegerField(verbose_name='Product Name'),
        ),
    ]
