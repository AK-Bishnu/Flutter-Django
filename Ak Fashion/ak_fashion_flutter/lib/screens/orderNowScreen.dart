import 'package:ak_fashion_flutter/screens/cartScreen.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderNowScreen extends StatelessWidget {
  const OrderNowScreen({super.key});
  static const routeName = '/orderNowScreen';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _email = '';
    String _phone = '';
    String _address = '';

    Future<void> orderNow()async{
      var isValid = _formKey.currentState?.validate();
      if(!isValid!){
        return;
      }
      _formKey.currentState?.save();
      final cart = Provider.of<CartState>(context,listen: false).cart;
      Map<String,dynamic> data = {
        'id' : cart.id,
        'email' : _email,
        'phone': _phone,
        'address' : _address
      };
       bool res = await Provider.of<CartState>(context,listen: false).orderCart(data);
       if(res){
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               content: Text('Cart is Ordered successfully'),
               backgroundColor: Colors.green,
               duration: Duration(seconds: 2),
             )
         );
         Navigator.pop(context);
       }else{
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               content: Text('Order failed'),
               backgroundColor: Colors.red,
               duration: Duration(seconds: 2),
             )
         );
       }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Order Now')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Enter Your Email";
                }
                return null;
              },
              onSaved: (v) {
                _email = v!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Phone"),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Enter Your Phone";
                }
                return null;
              },
              onSaved: (v) {
                _phone = v!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Address"),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Enter Your Address";
                }
                return null;
              },
              onSaved: (v) {
                _address = v!;
              },
            ),

            Row(
              children: [
                ElevatedButton(onPressed: (){
                  orderNow();
                }, child: Text('Order')),
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, CartScreen.routeName);
                }, child: Text('Edit Cart')),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
