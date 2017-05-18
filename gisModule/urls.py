from django.conf.urls import url
import gisModule
from . import views

app_name = 'gisModule'
urlpatterns = [
    url(r'^shop/', gisModule.views.shop, name='shop'),
    url(r'^login/$', gisModule.views.login, name="login"),
    url(r'^cart/$', gisModule.views.cart, name="cart"),
    url(r'^account/$', gisModule.views.account, name="account"),
]
