# Generated by Django 4.2.16 on 2024-11-29 20:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('movies', '0002_recommendationfeedback'),
    ]

    operations = [
        migrations.AlterField(
            model_name='movie',
            name='cast',
            field=models.ManyToManyField(blank=True, to='movies.castmember'),
        ),
        migrations.AlterField(
            model_name='movie',
            name='directors',
            field=models.ManyToManyField(blank=True, to='movies.director'),
        ),
        migrations.AlterField(
            model_name='movie',
            name='genres',
            field=models.ManyToManyField(blank=True, to='movies.genre'),
        ),
        migrations.AlterField(
            model_name='movie',
            name='keywords',
            field=models.ManyToManyField(blank=True, to='movies.keyword'),
        ),
    ]
