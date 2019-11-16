from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('buslist/', views.buslist),
    path('details/<int:bus>/<int:bpoint>/', views.details),
]