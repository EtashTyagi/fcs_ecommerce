# Generated by Django 3.2.10 on 2021-12-11 20:45

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('store', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Transaction',
            fields=[
                ('price', models.DecimalField(decimal_places=2, max_digits=13)),
                ('stripe_transaction_id', models.CharField(max_length=100, primary_key=True, serialize=False)),
                ('status', models.CharField(max_length=20)),
                ('buyer', models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='transaction_buyer', to=settings.AUTH_USER_MODEL)),
                ('item', models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.SET_NULL, to='store.product')),
                ('seller', models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='transaction_seller', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
