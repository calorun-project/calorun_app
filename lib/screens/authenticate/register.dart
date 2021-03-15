import 'package:calorun/services/auth.dart';
import 'package:calorun/shared/constants.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices authServices = AuthServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  String uid = '';
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';  
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Waiting() : Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: header(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                      "Welcome to Calorun!",
                      style: TextStyle(
                        //fontFamily: "TropicalAsian",
                        fontWeight: FontWeight.w800,
                        fontSize: 25.0,
                        color: Color(0xff297373)
                      ),
                    ),

                // First name
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'First name'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your first name' : null,
                  onChanged: (val) {
                    setState(() => firstName = val);
                  },
                ),
                // Last name
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Last name'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your last name' : null,
                  onChanged: (val) {
                    setState(() => lastName = val);
                  },
                ),
                // email
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
                // password
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
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      String result = await authServices.registerWithEmailAndPassword(email, password, firstName, lastName);
                      if (result == null) {
                        setState(() {
                          error = 'The email is invalid or has been used by an another account';
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
                SizedBox(height: 10.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                Text(
                    "Already have an account?",
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
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}