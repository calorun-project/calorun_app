import 'package:calorun/game/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Color(-14060685),
                border: Border.all(color: Color(-14060685), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "ENTER GAME",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameHome())),
                }));
  }
}
