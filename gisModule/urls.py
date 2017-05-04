from django.conf.urls import url, include
from . import views

app_name = 'gisModule'
urlpatterns = [
    url(r'^shopping/', views.shopping, name='shopping'),
    url(r'^login/$', views.login, name="login"),
]
