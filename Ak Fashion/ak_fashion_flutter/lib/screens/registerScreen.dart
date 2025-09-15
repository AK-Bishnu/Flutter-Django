import 'package:ak_fashion_flutter/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/userState.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _username = '';
  var _password = '';
  var _confirmPass = '';

  final _form = GlobalKey<FormState>();

  Future<void> _onReg() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState?.save();

    final res = await Provider.of<UserState>(context, listen: false)
        .registerNow(_username, _password);

    if (res) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed! Please check your credentials.'),
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
        title: Text('Register Here'),
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
                    onChanged: (value) {
                      setState(() {
                        _confirmPass = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    autocorrect: false,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter confirmation Password';
                      }
                      if(value!=_confirmPass){
                        return 'Password didnot match';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _confirmPass = newValue!;
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm your Password",
                    ),
                    obscureText: true,
                    autocorrect: false,
                  ),
                  ElevatedButton(onPressed: _onReg, child: Text('Register')),
                ],
              )),
        ),
      ),
    );
  }
}
