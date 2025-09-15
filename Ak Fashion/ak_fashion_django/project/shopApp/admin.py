from django.contrib import admin
from .models import Cart,CartProduct,Category,Order,Favourite,Product

# Register your models here.
admin.site.register([Cart,CartProduct,Category,Order,Favourite,Product])
