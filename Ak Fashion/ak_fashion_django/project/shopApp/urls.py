from django.urls import path
from .views import *
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('products/',ProductView.as_view()),
    path('favourites/',FavouriteView.as_view()),
    path('login/',obtain_auth_token),
    path('register/',RegisterView.as_view()),
    path('cart/',CartView.as_view()),
    path('order/',OrderView.as_view()),
    path('addToCart/',AddToCart.as_view()),    
    path('deleteCartProduct/',DeleteCartProduct.as_view()),    
    path('deleteCart/',DeleteCart.as_view()),    
    path('orderCart/',OrderCart.as_view()),    
]