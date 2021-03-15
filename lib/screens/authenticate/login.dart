import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/loading.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calorun/services/auth.dart';
import 'package:calorun/shared/constants.dart';
//import 'package:calorun/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Waiting() : Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: header(),
      body: SingleChildScrollView(
        child:  Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: SingleChildScrollView(
            child:  Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                      //fontFamily: "TropicalAsian",
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                      color: Color(0xff297373)
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20.00,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => (val.length < 6)
                        ? 'A password must be at leasst 6 character'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 20.00,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color(0xff297373).withOpacity(0.6);
                          return Color(0xff297373); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        print('hi');
                        String result = await _auth
                            .signInWithEmailAndPassword(email, password);
                            print('bye');
                        if (result == null) {
                          setState(() {
                            error = 'Something is wrong';
                            loading = false;
                          });
                        }
                        else {
                          loading = false;
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle( 
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color(0xff297373).withOpacity(0.6);
                          return Color(0xff297373); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                  ),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}