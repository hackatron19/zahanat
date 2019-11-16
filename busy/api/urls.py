from django.urls import path, include
from rest_framework import routers
from api import views

router = routers.DefaultRouter()
router.register('loc', views.BusLocViewSet)
router.register('bus', views.BusViewSet,basename="bus")
router.register('route', views.RouteViewSet)
router.register('bpoint', views.BPointViewSet,basename="bpoint")

urlpatterns = [
    path('', include(router.urls))
]
