import 'package:calorun/gameengine/gamedataGE.dart';
import 'home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cat extends StatefulWidget {
  CatBuild createState() => CatBuild();
}

double fat = 0.0;

class CatBuild extends State<Cat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(-14060685),
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Color(-15580606),
            ),
            iconSize: 32,
            tooltip: "Back to home",
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            "CALO THE CAT",
            style: TextStyle(
                fontSize: 30,
                color: Color(-15580606),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment(0.0, -0.4),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                "Level ${Calo.level}",
                style: TextStyle(fontSize: 30, color: Color(-14060685)),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                          child: RotationTransition(
                            child: CircularProgressIndicator(
                              value: Calo.exp / Calo.maxExp(),
                              backgroundColor: Colors.black,
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(-14060685)),
                            ),
                            turns: AlwaysStoppedAnimation(1 / 2),
                          )),
                      Image(
                        image: AssetImage("assets/images/Cat.gif"),
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                      )
                    ],
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: 400,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.32,
                  0,
                  MediaQuery.of(context).size.width * 0.32,
                  0),
              child: Row(
                children: [
                  Text(
                    "Height: \nWeight: ",
                    style: TextStyle(fontSize: 13, color: Color(-220399)),
                  ),
                  Spacer(),
                  Text(
                    "${Calo.height} inches \n${(Calo.weight).toStringAsFixed(1)} kg",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(120),
                        topRight: Radius.circular(120))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      child: InkWell(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Color(-14060685),
                            shape: BoxShape.circle,
                          ),
                        ),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameHome()))
                        },
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.height * 0.4,
                          child: RotationTransition(
                            child: CircularProgressIndicator(
                              value: (Calo.weight - Calo.minWeight) /
                                  ((Calo.maxWeight - Calo.minWeight) * 2),
                              backgroundColor: Colors.black,
                              strokeWidth: 20,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Color(-220399)),
                            ),
                            turns: AlwaysStoppedAnimation(-1 / 4),
                          )),
                    )
                  ],
                )),
          ],
        ));
  }
}
