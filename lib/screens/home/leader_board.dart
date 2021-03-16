import 'dart:ui';

import 'package:calorun/models/user.dart';
import 'package:calorun/widget/header.dart';

import 'package:flutter/material.dart';

import 'dart:math';


class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class LeaderBoardItem {
  String userId;
  String name;
  int totalCalory;
  String avt;
  LeaderBoardItem({this.userId, this.name, this.totalCalory, this.avt});
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<LeaderBoardItem> _leaderBoardItems = [];

  List<ModifiedUser> _users = [];
  @override
  Widget build(BuildContext context) {
    generateDummyData();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [              
                //Draw column chart
                Container(
                  height: 350,
                  color: Color(0xff14213D),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                            ),
                            backgroundColor: Colors.red,
                            radius: 27,
                          ),
                          SizedBox(height: 10,),

                          Text(
                            _leaderBoardItems[1].totalCalory.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10,), 

                          Container(
                            width: 70,                       
                            height: (_leaderBoardItems[1].totalCalory * 1.0 / _leaderBoardItems[0].totalCalory * 1.0)*160 ,
                            color: Color(
                              0xffFCA311
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "2nd",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffFFFFFF),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 50,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                            ),
                            backgroundColor: Colors.red,
                            radius: 27,
                          ),
                          SizedBox(height: 10,),

                          Text(
                            _leaderBoardItems[0].totalCalory.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: 70,
                            height: (_leaderBoardItems[0].totalCalory * 1.0 / _leaderBoardItems[0].totalCalory * 1.0)*160,
                            color: Color(
                              0xffFCA311
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "1st",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffFFFFFF),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 50,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                            ),
                            backgroundColor: Colors.red,
                            radius: 27,
                          ),
                          SizedBox(height: 10,),

                          Text(
                            _leaderBoardItems[2].totalCalory.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: 70,
                            height: (_leaderBoardItems[2].totalCalory * 1.0 / _leaderBoardItems[0].totalCalory * 1.0)*160,
                            color: Color(
                              0xffFCA311
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "3rd",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffFFFFFF),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                  
                ),
                Container(
                  color: Color(0xff14213d),
                  height: 30,
                ),

                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _leaderBoardItems.length,
                      itemBuilder: (BuildContext ctxt, int index) =>
                          buildList(ctxt, index)),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),

          new Positioned(
          bottom: 0,
      child: new Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 80.0,
            decoration: new BoxDecoration(color: Colors.transparent),
            child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.all(Radius.circular(15.0)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 25),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Text(
                                "10",
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ),
                          ),
                        ),
                        Align(
                          child: CircleAvatar(
                            backgroundColor: Colors.red.shade800,
                            child: Text('GI'),
                            radius: 30,
                          ),
                        ),
                        Align(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: Text(
                                "me",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                   "1000",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
            )
          ),
        ],
      )
    );
    // );
  }

  Widget buildList(BuildContext ctxt, int index) {
    int ind = index + 1;
    Widget crown;
    if (ind == 1) {
      crown = CircleAvatar(
          backgroundColor: Colors.yellow[800],
          radius: 20,
          child: Text(
            ind.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ));
    } else if (ind == 2) {
      crown = CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: 20,
          child: Text(
            ind.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ));
    } else if (ind == 3) {
      crown = CircleAvatar(
          backgroundColor: Colors.brown,
          radius: 20,
          child: Text(
            ind.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ));
    } else {
      crown = CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 20,
          child: Text(
            ind.toString(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ));
    }

    Color c;
    if (ind % 2 != 0)
      c = Colors.white;
    else
      c = Color(0xffF5F5F5);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: c,
            //borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 25),
                          child: crown,
                        ),
                      ),
                      Align(
                        child: CircleAvatar(
                          backgroundColor: Colors.red.shade800,
                          child: Text('GI'),
                          radius: 30,
                        ),
                      ),
                      Align(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: Text(
                              _leaderBoardItems[index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _leaderBoardItems[index].totalCalory.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void generateDummyData() {
    _leaderBoardItems = [];
    for (var i = 1; i < 21; i++) {
      Random random = new Random();
      int randomNumber = random.nextInt(2000);
      LeaderBoardItem lbi = LeaderBoardItem(
        userId: 'user$i',
        name: 'User $i',
        totalCalory: (randomNumber),
      );
      _leaderBoardItems.add(lbi);
    }
    _leaderBoardItems.sort((a, b) => a.totalCalory.compareTo(b.totalCalory));
    _leaderBoardItems = _leaderBoardItems.reversed.toList();
  }
}
