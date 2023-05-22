from django.urls import path
from . import views

urlpatterns = [
    path('', views.hello, name='hello'),
    path('img1/', views.img1, name='img1'),
    path('img2/', views.img2, name='img'),
]
