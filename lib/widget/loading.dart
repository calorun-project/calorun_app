import 'package:flutter/material.dart';

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
