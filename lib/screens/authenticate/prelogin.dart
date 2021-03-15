import 'package:calorun/screens/authenticate/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Prepage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(20, 33, 61, 1),
              Color(0xff1A364B),
              Color(0xff1F4A58),
              Color(0xff245F66),
              Color.fromRGBO(41, 115, 115, 1),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Calorun',
              style: TextStyle(
                fontFamily: 'Spantaran',
                fontWeight: FontWeight.w300,
                fontSize: 90.0,
                color: Colors.white,
                ), 
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffFCA311),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Authenticate()),
                );},
                child: Text('Sign in'),              
            ),
          ],
        ),
      ),
    );
  }
}