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