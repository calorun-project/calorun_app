import 'package:flutter/material.dart';

final CircularProgressIndicator loadIcon = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(Colors.black),
);

const InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff297373), width: 2.0),
  ),
);

AppBar header() {
  return AppBar(
    title: Text(
      "Calorun",
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Spantaran",
        fontSize: 50.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Color(0xff297373),
  );
}

Widget waiting() {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Text(
        "Calorun",
        style: TextStyle(
          fontSize: 75,
          color: Color(0xff297373),
          fontFamily: "Spantaran",
        ),
      ),
    ),
  );
}

Widget circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Color(0xff297373)),
    ),
  );
}

Widget linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Color(0xffFCA311)),
      backgroundColor: Color(0xff297373),
    ),
  );
}

Widget circularWaiting() {
  return Scaffold(
    body: circularProgress(),
  );
}

Widget noInternetApp(BuildContext context) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      const Text('Please wait for the internet connection!'),
                  duration: Duration(milliseconds: 500),
                ),
              );
            },
            child: Text('Sign in'),
          ),
        ],
      ),
    ),
  );
}
