import 'package:calorun/services/auth.dart';
import 'package:calorun/shared/widget_resource.dart';
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
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';  
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? waiting() : Scaffold(
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
                  validator: (value) =>
                    (value.isEmpty) ?
                    'Please enter your first name' :
                    ((RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9- ]').hasMatch(value)) ?
                    'Please enter a valid Name' :
                    null),
                  onChanged: (value) {
                    setState(() => firstName = value);
                  },
                ),
                // Last name
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Last name'),
                  validator: (value) =>
                    (value.isEmpty) ?
                    'Please enter your first name' :
                    ((RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) ?
                    'Please enter a valid Name' :
                    null),
                  onChanged: (value) {
                    setState(() => lastName = value);
                  },
                ),
                // email
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter an email' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                // password
                SizedBox(
                  height: 20.00,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (value) => (value.length < 6)
                      ? 'A password must be at leasst 6 character'
                      : null,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(
                  height: 20.00,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Conrfim password'),
                  obscureText: true,
                  validator: (value) => (value != password)
                      ? 'The corfirm password is not valid'
                      : null,
                  onChanged: (value) {
                    setState(() => confirmPassword = value);
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
                          return Color(0xff297373);
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