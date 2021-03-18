
import 'package:calorun/widget/user/search.dart';
import 'package:flutter/material.dart';


Widget navigateHeader(BuildContext context) {
  return AppBar(
    actions: <Widget>[
      IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchUser()),
            );
          },
          ),
    ],

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
