import 'package:flutter/material.dart';
import 'package:calorun/services/auth.dart';
import 'package:calorun/shared/constants.dart';
import 'package:calorun/shared/loading.dart';

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
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green[400],
      appBar: AppBar(
        backgroundColor: Color(297373),
        title: Text('Register'),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
                decoration: textInputDecoration.copyWith(hintText: 'First name'),
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
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
