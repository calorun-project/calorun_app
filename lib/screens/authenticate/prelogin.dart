import 'package:calorun/screens/authenticate/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Prepage extends StatelessWidget {
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInternet(),
      builder: (context, snapshot) {
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Calorun',
                      style: TextStyle(
                        fontFamily: 'Spantaran',
                        fontWeight: FontWeight.w300,
                        fontSize: 90.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFCA311),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    if (!snapshot.hasData) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please wait for the internet connection!'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );                      
                    }
                    else if (!snapshot.data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('No internet conection!'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    }
                    else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Authenticate()),
                      );
                    }
                  },
                  child: Text('Sign in'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
