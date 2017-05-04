# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-27 09:49
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('gisModule', '0032_auto_20170227_0940'),
    ]

    operations = [
        migrations.CreateModel(
            name='GroupGroupEdge',
            fields=[
                ('edgeID', models.AutoField(primary_key=True, serialize=False)),
                ('child', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='GroupGroupChild', to='gisModule.ProductGroup')),
                ('parent', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='GroupGroupParent', to='gisModule.ProductGroup')),
            ],
        ),
        migrations.CreateModel(
            name='GroupProductEdge',
            fields=[
                ('edgeID', models.AutoField(primary_key=True, serialize=False)),
                ('child', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='GroupProductChild', to='gisModule.BaseProduct')),
                ('parent', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='GroupProductParent', to='gisModule.ProductGroup')),
            ],
        ),
        migrations.RemoveField(
            model_name='treeedge',
            name='child',
        ),
        migrations.RemoveField(
            model_name='treeedge',
            name='parent',
        ),
        migrations.DeleteModel(
            name='TreeEdge',
        ),
    ]
