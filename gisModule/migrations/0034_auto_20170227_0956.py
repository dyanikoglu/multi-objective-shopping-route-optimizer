# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-27 09:56
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0033_auto_20170227_0949'),
    ]

    operations = [
        migrations.CreateModel(
            name='TreeEdge',
            fields=[
                ('edgeID', models.AutoField(primary_key=True, serialize=False)),
            ],
        ),
        migrations.RemoveField(
            model_name='groupgroupedge',
            name='child',
        ),
        migrations.RemoveField(
            model_name='groupgroupedge',
            name='parent',
        ),
        migrations.RemoveField(
            model_name='groupproductedge',
            name='child',
        ),
        migrations.RemoveField(
            model_name='groupproductedge',
            name='parent',
        ),
        migrations.RenameField(
            model_name='productgroup',
            old_name='childConnectionID',
            new_name='childConnection',
        ),
        migrations.RenameField(
            model_name='productgroup',
            old_name='parentConnectionID',
            new_name='parentConnection',
        ),
        migrations.DeleteModel(
            name='GroupGroupEdge',
        ),
        migrations.DeleteModel(
            name='GroupProductEdge',
        ),
        migrations.AddField(
            model_name='treeedge',
            name='child',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='GroupGroupChild', to='gisModule.ProductGroup'),
        ),
        migrations.AddField(
            model_name='treeedge',
            name='parent',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='GroupGroupParent', to='gisModule.ProductGroup'),
        ),
    ]
