from django.http import HttpResponse
from django.shortcuts import render
import socket
from img_project.context_processors import gunicorn_port
from urllib.request import urlopen

hostname = socket.gethostname()

def img(request):
    return HttpResponse(f"Image on {hostname}, port: { gunicorn_port(request)}")
    
def img1(request):
    return HttpResponse(f"Image1 on {hostname}, port: { gunicorn_port(request)}")
    
def img2(request):
    return HttpResponse(f"Image2 on {hostname}, port: { gunicorn_port(request)}")

def githublink(request):
    image_url = "https://github.com/hojat-gazestani/DevOps/blob/main/haproxy/pictures/02-OSI%20model.jpg"
    return HttpResponse(f"<img src='{image_url}' alt='GitHub Image'>")

#def githublink(request):
#    image_url = "https://github.com/hojat-gazestani/DevOps/blob/main/haproxy/pictures/02-OSI%20model.jpg"
#    try:
#        image_data = urlopen(image_url).read()
#        return HttpResponse(image_data, content_type="image/jpeg")
#    except Exception as e:
#        return HttpResponse(f"Error loading image: {str(e)}")
