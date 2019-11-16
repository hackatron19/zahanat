from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('list/', views.buslist, name='list'),
    path('details/<int:bus>/<int:bpoint>/', views.details, name='details'),
    path('about/', views.about, name='about'),
]