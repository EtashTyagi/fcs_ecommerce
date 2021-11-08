# Generated by Django 3.2.8 on 2021-11-08 09:34

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('seller_uid', models.IntegerField()),
                ('title', models.CharField(max_length=25)),
                ('short_description', models.CharField(max_length=200)),
                ('description', models.CharField(max_length=5000)),
                ('price', models.DecimalField(decimal_places=2, max_digits=13)),
                ('image_1', models.CharField(max_length=1000)),
                ('image_2', models.CharField(max_length=1000)),
                ('image_3', models.CharField(blank=True, max_length=1000, null=True)),
                ('image_4', models.CharField(blank=True, max_length=1000, null=True)),
                ('image_5', models.CharField(blank=True, max_length=1000, null=True)),
                ('available_quantity', models.IntegerField()),
                ('category', models.CharField(max_length=100)),
            ],
        ),
    ]