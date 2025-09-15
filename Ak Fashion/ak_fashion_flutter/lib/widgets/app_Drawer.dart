import 'package:ak_fashion_flutter/screens/HomeScreen.dart';
import 'package:ak_fashion_flutter/screens/cartScreen.dart';
import 'package:ak_fashion_flutter/screens/favouriteScreen.dart';
import 'package:ak_fashion_flutter/screens/loginScreen.dart';
import 'package:ak_fashion_flutter/screens/orderScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> onLogout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('AK Fashion'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, Homescreen.routeName);
            },
            trailing: Icon(Icons.home,color: Colors.blueAccent,),
            title: Text("Home"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, FavouriteScreen.routeName);
            },
            trailing: Icon(Icons.favorite_outlined,color: Colors.red,),
            title: Text("Favourites"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, CartScreen.routeName);
            },
            trailing: Icon(Icons.shopping_cart,color: Colors.blue,),
            title: Text("Cart"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
            trailing: Icon(Icons.history,color: Colors.blue,),
            title: Text("Orders"),
          ),
          Spacer(),
          ListTile(
            onTap: (){
              onLogout();
            },
            trailing: Icon(Icons.logout,color: Colors.red,),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
