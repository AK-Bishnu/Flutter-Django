import 'package:ak_fashion_flutter/screens/HomeScreen.dart';
import 'package:ak_fashion_flutter/screens/registerScreen.dart';
import 'package:ak_fashion_flutter/state/userState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';
  final _form = GlobalKey<FormState>();

  Future<void> _onLogin() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState?.save();

    final res = await Provider.of<UserState>(context, listen: false)
        .loginNow(_username, _password);

    if (res) {
      Navigator.pushReplacementNamed(context, Homescreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed! Please check your credentials.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Here'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please Enter Username';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _username = newValue!;
                },
                decoration: InputDecoration(
                  labelText: "Username"
                ),
              ),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please Enter Password';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _password = newValue!;
                },
                decoration: InputDecoration(
                    labelText: "Password",
                ),
                obscureText: true,
              ),
              ElevatedButton(onPressed: _onLogin, child: Text('Login')),
              Row(
                children: [
                  Text("Don't have an account? "),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  }, child: Text('Register',style: TextStyle(color: Colors.blue),))
                ],
              )

            ],
          )),
        ),
      ),
    );
  }
}
