# Generated by Django 4.2.16 on 2024-11-29 20:57

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('movies', '0003_alter_movie_cast_alter_movie_directors_and_more'),
    ]

    operations = [
        # Comment out or remove the AddField operation
        # migrations.AddField(
        #     model_name='rating',
        #     name='timestamp',
        #     field=models.DateTimeField(auto_now_add=True),
        # ),
        migrations.AlterField(
            model_name='rating',
            name='comment',
            field=models.TextField(blank=True),
        ),
    ]