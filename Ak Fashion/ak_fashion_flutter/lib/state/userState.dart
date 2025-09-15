import 'dart:convert';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserState with ChangeNotifier{


  Future<bool> loginNow(String username, String password) async{
    String url = '${ProductState.baseUrl}login/'.trim();
    try{
      final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type' : 'application/json'
        },
        body: jsonEncode(
          {
            "username" : username,
            "password" : password
          }
        ),
      );
      final data = jsonDecode(response.body) as Map;
      if(data.containsKey("token")){
        print(data['token']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);
        return true;
      }
      return false;
    }catch(e){
      print('Error of LoginNow');
      print(e);
      return false;
    }
  }

  Future<bool> registerNow(String username, String password) async{
    String url = '${ProductState.baseUrl}register/'.trim();
    try{
      final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type' : 'application/json'
        },
        body: jsonEncode(
            {
              "username" : username,
              "password" : password 
            }
        ),
      );
      final data = jsonDecode(response.body) as Map;
      if(!data['error']){
        return true;
      }
      return false;
    }catch(e){
      print('Error of RegisterNow');
      print(e);
      return false;
    }
  }
}