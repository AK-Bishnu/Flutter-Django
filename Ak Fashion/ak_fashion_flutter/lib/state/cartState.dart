import 'dart:convert';

import 'package:ak_fashion_flutter/models/CartModel.dart';
import 'package:ak_fashion_flutter/models/OrderModel.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartState with ChangeNotifier{
  Future<String>getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString('auth_token').toString();
  }
  CartModel ?_cartModel;
  List<OrderModel> _orders =[];
  Future<void> fetchCart() async {
    String url = '${ProductState.baseUrl}/api/cart/'.trim();
    final token = await getToken();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization' :  'token $token'
      });
      var data = jsonDecode(response.body) as Map;
      print('from cartstate');
      //print(data);
      //print(data['error']);
      List<CartModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          CartModel cartModel = CartModel.fromJson(element);
          demo.add(cartModel);
        });
        _cartModel = demo[0];
        notifyListeners();
        //print(_cartModel?.cartproducts);
      }else{
       print(data['data']);
      }
    } catch (e) {
      print('error of getting Cart');
      print(e);
    }
  }
  CartModel get cart {
    return _cartModel ?? CartModel(cartproducts: []);
  }

  Future<void> fetchOrders() async {
    String url = '${ProductState.baseUrl}/api/order/'.trim();
    final token = await getToken();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization' :  'token $token'
      });

      var data = jsonDecode(response.body) as Map;

      List<OrderModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderModel orderModel = OrderModel.fromJson(element);
          demo.add(orderModel);
        });
        _orders = demo;
        notifyListeners();
        //print(_cartModel?.cartproducts);
      }else{
        print(data['data']);
      }
    } catch (e) {
      print('error of getting Orders');
      print(e);
    }
  }
  List<OrderModel> get orders {
    return [..._orders];
  }

  Future<void>deleteCartProduct(int id) async {
    String url = '${ProductState.baseUrl}/api/deleteCartProduct/'.trim();
    final token = await getToken();
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json'
      },
          body: jsonEncode({
            'id': id
          })
      );
      var data = jsonDecode(response.body) as Map;
      if (data['error'] == false) {
        fetchCart();
      }
    } catch (e) {
      print('error of delete cart product');
      print(e);
    }
  }

  Future<void>deleteCart(int id) async {
    String url = '${ProductState.baseUrl}/api/deleteCart/'.trim();
    final token = await getToken();
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json'
      },
          body: jsonEncode({
            'id': id
          })
      );
      var data = jsonDecode(response.body) as Map;
      if (data['error'] == false) {
        fetchCart();
        _cartModel = null;
        notifyListeners();
      }
    } catch (e) {
      print('error of delete cart');
      print(e);
    }
  }

  Future<bool>orderCart(Map<String,dynamic> data) async {
    Map<String,dynamic> tem = data;
    String url = '${ProductState.baseUrl}/api/orderCart/'.trim();
    final token = await getToken();
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'token $token',
        'Content-Type': 'application/json'
      },
          body: jsonEncode(tem)
      );
      var data = jsonDecode(response.body) as Map;
      if (data['error'] == false) {
        fetchCart();
        fetchOrders();
        _cartModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('error of Ordering Cart');
      print(e);
      return false;
    }
  }
}