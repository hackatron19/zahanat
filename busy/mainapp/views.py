from django.shortcuts import render
from .models import Route, BPoint, Bus, BusLoc
from django.views.decorators.csrf import csrf_exempt
import requests

def index(request):
    context = {
        'routes':Route.objects.all(),
        'bpoints':BPoint.objects.all()
    }
    return(render(request, 'mainapp/home.html', context))


def buslist(request):
    if request.method=="POST":
        route = request.POST.get("route")
        bpoint_selected = request.POST.get("bpoint")
        buses = Bus.objects.filter(route=route)
                
        context = {
            "routes" : Route.objects.all(),
            "buses" : buses,
            "bpoint_selected" : BPoint.objects.get(id=bpoint_selected)
        }
        return render(request, 'mainapp/list.html', context=context)
    
    return render(request, 'mainapp/home.html')
    

def details(request, bus, bpoint):
    bus = Bus.objects.get(id=bus)
    bus_lat = bus.busloc.lat
    bus_long = bus.busloc.long
    bpoint_selected = BPoint.objects.get(id=bpoint)
    bpoint_lat = bpoint_selected.lat
    bpoint_long = bpoint_selected.long
    key = "Ajb5cBYG4DdffO9dIl4wRR3RVQSEhOQ4zOXIGWxURNl24Ro6E9qOgcwGBHwsuW6v"
    dist_mat = requests.get(f"https://dev.virtualearth.net/REST/v1/Routes/DistanceMatrix?origins={bus_lat},{bus_long}&destinations={bpoint_lat},{bpoint_long}&travelMode=driving&key={key}")
    response = dist_mat.json()
    travelDuration = round(float(response["resourceSets"][0]["resources"][0]["results"][0]["travelDuration"]),1)
    travelDistance = int(response["resourceSets"][0]["resources"][0]["results"][0]["travelDistance"])

    context = {
        "response" : {"travelDuration":travelDuration, "travelDistance":travelDistance},
        "buses" : Bus.objects.filter(id=bus.id),
        "bpoint" : {"bp": bpoint_selected} 
    }
    return render(request, 'mainapp/details.html', context=context)
    