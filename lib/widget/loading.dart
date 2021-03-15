import 'package:flutter/material.dart';


Widget Waiting(){
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

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),),
  );
}