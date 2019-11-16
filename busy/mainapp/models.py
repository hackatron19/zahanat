from django.db import models

# Create your models here.
class Route(models.Model):
    source = models.CharField(max_length=50)
    destination = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.source} to {self.destination}"

class BPoint(models.Model):
    name = models.CharField(max_length=50)
    code = models.CharField(max_length=3)
    lat = models.FloatField(default=0.0)
    long = models.FloatField(default=0.0)
    routes = models.ManyToManyField(to=Route, related_name="bpoints")

    def __str__(self):
        return f"{self.name}"

class Bus(models.Model):
    bno = models.CharField(max_length=10)
    driver = models.CharField(max_length=50)
    conductor = models.CharField(max_length=50)
    route = models.ForeignKey(to=Route, on_delete=models.CASCADE)
    status = models.IntegerField()

    def __str__(self):
        return f"{self.bno}"

class BusLoc(models.Model):
    bus = models.OneToOneField(to=Bus, on_delete=models.CASCADE)
    lat = models.FloatField(default=0.0)
    long = models.FloatField(default=0.0)
    def get_bno(self):
        return f"{self.bus.bno}"

    def __str__(self):
        return f"{self.bus.bno}"