from .serializers import *
from .models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication


class ProductView(APIView):
    permission_classes = [IsAuthenticated,]
    authentication_classes = [TokenAuthentication,]
    #above two are for only authentic users view
    def get(self,request):
        query = Product.objects.all()
        serializers = ProductSerializer(query,many=True)
        data = []
        for product in serializers.data:
          fab_query = Favourite.objects.filter(user = request.user).filter(
             product_id = product['id']
          )
          if fab_query:
             product['favourite'] = fab_query[0].isFavourite
          else:
             product['favourite'] = False

          data.append(product)
        
        return Response(data)

class FavouriteView(APIView):
   permission_classes = [IsAuthenticated]
   authentication_classes = [TokenAuthentication]
   def post(self,request):
      data = request.data['id']
      try:
         product_obj = Product.objects.get(id=data)
         user = request.user
         single_favourite_product = Favourite.objects.filter(user=user).filter(product=product_obj).first()
         if single_favourite_product:
            print('single favourite product')
            flag = single_favourite_product.isFavourite
            single_favourite_product.isFavourite = not flag
            single_favourite_product.save()
         else:
            Favourite.objects.create(product = product_obj, user = user,isFavourite = True)
         response_msg = {'error' : False}
      except:
         response_msg = {'error' : True}
      return Response(response_msg)   
   
class RegisterView(APIView):
   def post(self,request):
      serializers = UserSerializer(data = request.data)
      if serializers.is_valid():
         serializers.save()
         return Response({"Error" : False})
      return Response({"Error" : True})
   
class CartView(APIView):
   permission_classes=[IsAuthenticated,]
   authentication_classes = [TokenAuthentication]

   def get(self,request):
      user = request.user
      try:
         cart_obj = Cart.objects.filter(user=user).filter(isComplete=False)
         data=[]
         cart_serializer = CartSerializer(cart_obj,many=True)
         for cart in cart_serializer.data:
            cart_data = dict(cart)
            cart_product_obj = CartProduct.objects.filter(cart=cart['id'])
            cart_product_obj_serializer = CartProductSerializer(cart_product_obj,many=True)
            cart_data['cartproducts'] = cart_product_obj_serializer.data
            data.append(cart_data)
         response_msg = {"error" : False,"data":data}
      except:
         response_msg = {"error" : True,"data":"No data"}
      
      return Response(response_msg)
   

class OrderView(APIView):
   permission_classes = [IsAuthenticated]
   authentication_classes = [TokenAuthentication]
   def get(self,request):
      try:
         query = Order.objects.filter(cart__user = request.user)
         serializers = OrderSerializer(query, many = True)
         response_msg = {"error":False, "data":serializers.data}
      except:
         response_msg = {"error":True, "data":"No data"}
      
      return Response(response_msg)
   
class AddToCart(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    def post(self, request):
        try:
            product_id = request.data['id']
            product_obj = Product.objects.get(id=product_id)

            cart, created = Cart.objects.get_or_create(
                user=request.user, isComplete=False, defaults={'total': 0}
            )

            cart_product_qs = cart.cartproduct_set.filter(product=product_obj)

            if cart_product_qs.exists():
                cart_product = cart_product_qs.first()
                cart_product.quantity += 1
                cart_product.subtotal += product_obj.selling_price
                cart_product.save()
                cart.total += product_obj.selling_price
                cart.save()
            else:
                cart_product = CartProduct.objects.create(
                    cart=cart,
                    product=product_obj,
                    price=product_obj.selling_price,
                    quantity=1,
                    subtotal=product_obj.selling_price
                )
                cart.total += product_obj.selling_price
                cart.save()

            response_message = {
                'error': False,
                'message': "Product added to cart successfully",
                'productid': product_id
            }

        except Product.DoesNotExist:
            response_message = {'error': True, 'message': "Product not found"}

        except Exception as e:
            response_message = {'error': True, 'message': f"Something went wrong: {str(e)}"}

        return Response(response_message)

class DeleteCartProduct(APIView):
   authentication_classes = [TokenAuthentication]
   permission_classes = [IsAuthenticated]

   def post(self,request):
      cart_product_id = request.data['id']
      try:
         cart_product_obj = CartProduct.objects.get(id=cart_product_id)
         cart_obj = Cart.objects.filter(user=request.user).filter(isComplete=False).first()
         cart_obj.total -= cart_product_obj.subtotal
         cart_product_obj.delete()
         cart_obj.save()
         response_msg = {'error':False}
      except:
         response_msg = {'error':True}
      
      return Response(response_msg)

class DeleteCart(APIView):
   permission_classes = [IsAuthenticated]
   authentication_classes = [TokenAuthentication]

   def post(self, request):
      cart_id = request.data['id']
      try:
         cart_obj = Cart.objects.get(id=cart_id)
         cart_obj.delete()
         response_msg = {'error':False,}
      except:

         response_msg = {'error':True}
      
      return Response(response_msg)
   

class OrderCart(APIView):
   permission_classes = [IsAuthenticated]
   authentication_classes = [TokenAuthentication]

   def post(self, request):
      try:
         cart_id = request.data['id']
         email = request.data['email']
         phone = request.data['phone']
         address = request.data['address']
         cart_obj = Cart.objects.get(id=cart_id)
         cart_obj.isComplete=True
         cart_obj.save()

         Order.objects.create(
            cart = cart_obj,
            email = email,
            phone = phone,
            address = address
         )
         response_msg = {'error':False,"Msg":"Order is Placed Successfully"}
      except:
         response_msg = {'error':True,"Msg":"Something is wrong"}

      return Response(response_msg)