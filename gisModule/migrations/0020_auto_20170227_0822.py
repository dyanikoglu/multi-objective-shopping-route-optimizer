# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-27 08:22
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0019_auto_20170227_0821'),
    ]

    operations = [
        migrations.AlterField(
            model_name='treeedge',
            name='childNodeID',
            field=models.PositiveIntegerField(choices=[(-1, '------GROUPS------'), (8, 'Baby Products & Toys'), (5, 'Beverage'), (6, 'Cleaning Products'), (7, 'Cosmetic'), (1, 'Fruits & Vegetables'), (9, 'Furnitures & Other House Products'), (2, 'Meat & Fish'), (3, 'Milk & Breakfast'), (4, 'Nutrition & Confectionary'), (-1, '------PRODUCTS------'), (2, 'Pınar Yoğurt 500G'), (1, 'Sütaş Süt 1L'), (4, 'Torku Banada 1Piece'), (5, 'Ülker Sütlü Çikolata 1Piece'), (3, 'İçim Beyaz Peynir 250G')], null=True, verbose_name='Child Node ID'),
        ),
        migrations.AlterField(
            model_name='treeedge',
            name='parentNodeID',
            field=models.PositiveIntegerField(choices=[(8, 'Baby Products & Toys'), (5, 'Beverage'), (6, 'Cleaning Products'), (7, 'Cosmetic'), (1, 'Fruits & Vegetables'), (9, 'Furnitures & Other House Products'), (2, 'Meat & Fish'), (3, 'Milk & Breakfast'), (4, 'Nutrition & Confectionary')], null=True, verbose_name='Parent Node ID'),
        ),
    ]
