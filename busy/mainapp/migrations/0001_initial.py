# Generated by Django 2.2.7 on 2019-11-16 07:28

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Bus',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('bno', models.CharField(max_length=10)),
                ('driver', models.CharField(max_length=50)),
                ('conductor', models.CharField(max_length=50)),
                ('status', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Route',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('source', models.CharField(max_length=50)),
                ('destination', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='BusLoc',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('lat', models.FloatField(default=0.0)),
                ('long', models.FloatField(default=0.0)),
                ('bus', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='mainapp.Bus')),
            ],
        ),
        migrations.AddField(
            model_name='bus',
            name='route',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='mainapp.Route'),
        ),
        migrations.CreateModel(
            name='BPoint',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('code', models.CharField(max_length=3)),
                ('lat', models.FloatField(default=0.0)),
                ('long', models.FloatField(default=0.0)),
                ('routes', models.ManyToManyField(related_name='bpoints', to='mainapp.Route')),
            ],
        ),
    ]
