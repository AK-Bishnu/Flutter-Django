import 'package:ak_fashion_flutter/screens/HomeScreen.dart';
import 'package:ak_fashion_flutter/screens/cartScreen.dart';
import 'package:ak_fashion_flutter/screens/favouriteScreen.dart';
import 'package:ak_fashion_flutter/screens/loginScreen.dart';
import 'package:ak_fashion_flutter/screens/orderNowScreen.dart';
import 'package:ak_fashion_flutter/screens/orderScreen.dart';
import 'package:ak_fashion_flutter/screens/productDetails.dart';
import 'package:ak_fashion_flutter/screens/registerScreen.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:ak_fashion_flutter/state/userState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // needed before SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('auth_token'); // read token

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductState()),
        ChangeNotifierProvider(create: (context) => UserState()),
        ChangeNotifierProvider(create: (context) => CartState(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // if token exists → go to Homescreen, else LoginScreen
        home: isLoggedIn ? const Homescreen() : const LoginScreen(),
        routes: {
          Homescreen.routeName: (context) => const Homescreen(),
          ProductDetailsScreen.routeName: (context) => const ProductDetailsScreen(),
          FavouriteScreen.routeName: (context) => const FavouriteScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.routeName: (context)=> const OrderScreen(),
          OrderNowScreen.routeName : (context)=> const OrderNowScreen(),
        },
      ),
    );
  }
}
