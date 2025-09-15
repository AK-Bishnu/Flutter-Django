import 'dart:convert';
import 'package:ak_fashion_flutter/models/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductState with ChangeNotifier {
  static const String baseUrl = 'http://10.29.169.204:8000/api/';
  List<ProductModel> _products = [];
  Future<String?> getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString('auth_token');
  }

  Future<bool> getProducts() async {
    baseUrl.trim();
    String url = '${baseUrl}products/'.trim();
    final token = await getToken();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization' :  'token $token'
      });

      var data = jsonDecode(response.body) as List;
      //print(data);
      _products.clear();
      _products = data.map((e) => ProductModel.fromJson(e)).toList();
      notifyListeners();
      return true;
    } catch (e) {
      print('error of getting products');
      print(e);
      return false;
    }
  }

  List<ProductModel> get products{
    return _products;
  }
  ProductModel getSingleProduct(int id){
    return _products.firstWhere((element) => element.id==id,);
  }

  Future<void> favouriteButton(int id) async {
    String url = '${baseUrl}favourites/'.trim();
    final token =await getToken();
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization' :  'token $token',
        'Content-Type' : 'application/json'
      },
        body: json.encode({
          'id' : id
        })
      );
      // var data = jsonDecode(response.body) ;
      // print(data);
      await getProducts();
    } catch (e) {
      print('error of favourite button');
      print(e);
    }
  }
  List<ProductModel> get favourites{
    return _products.where((element) => element.favourite==true,).toList();
  }


  Future<bool> addToCart(int id ) async {
    String url = '${baseUrl}addToCart/'.trim();
    final token =await getToken();
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization' :  'token $token',
        'Content-Type' : 'application/json'
      },
          body: json.encode({
            'id' : id
          })
      );
      var data = jsonDecode(response.body);
      //print(data['error']);
      if(data['error']==false){

        return true;
      }else{
        return false;
      }
    } catch (e) {
      print('error of addToCart button');
      print(e);
      return false;
    }
  }
}
