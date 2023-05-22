from django.http import HttpResponse
from django.shortcuts import render
import socket
from img_project.context_processors import gunicorn_port

hostname = socket.gethostname()

def hello(request):
    return HttpResponse(f"Hello form {hostname}, port: { gunicorn_port(request)}")
    
def img1(request):
    return HttpResponse(f"Image1 on {hostname}, port: { gunicorn_port(request)}")
    
def img2(request):
    return HttpResponse(f"Image2 on {hostname}, port: { gunicorn_port(request)}")
