import 'dart:ui';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/modified_image.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  String _getUserRank(String uid, List<LeaderBoardUser> leaderBoard) {
    int pos = leaderBoard.indexWhere((element) => element.uid == uid);
    if (pos == -1) return 'No rank';
    return (pos + 1).toString();
  }
  Widget buildList(BuildContext ctxt, int index , List<LeaderBoardUser> _leaderBoardItems) {
    int ind = index + 1;
    Widget crown;
    if (ind == 1) {
      crown = CircleAvatar(
        backgroundColor: Colors.yellow[800],
        radius: 20,
         Text(
          ind.toString(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    } else if (ind == 2) {
      crown = CircleAvatar(
        backgroundColor: Colors.blueGrey,
        radius: 20,
        child: Text(
          ind.toString(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      );
    } else if (ind == 3) {
      crown = CircleAvatar(
        backgroundColor: Colors.brown,
        radius: 20,
        child: Text(
          ind.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      );
    } else {
      crown = CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 20,
        child: Text(
          ind.toString(),
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: ind % 2 != 0 ? Colors.white : Color(0xffF5F5F5),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)],
        ),
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
                          backgroundImage: AssetImage("assets/images/default-avatar.png"),
                          foregroundImage: modifiedImageNetwork(
                            _leaderBoardItems[index]?.avtUrl,
                          ),
                          radius: MediaQuery.of(context).size.width*0.08,
                        ),
                      ),
                      Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: Container(
                                color: Colors.blue,
                                width: MediaQuery.of(context).size.width*0.25,
                                child: Text(
                                _leaderBoardItems[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                                 overflow: TextOverflow.ellipsis,
                              ),
                                 
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  (_leaderBoardItems[index].totalDistance / 1000)
                      .toStringAsFixed(0) + ' km',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {    
    return FutureBuilder(
      future: DatabaseServices.getDistanceLeaderBoard(10),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return circularWaiting();
        List<LeaderBoardUser> _leaderBoardItems = snapshot.data;
        while (_leaderBoardItems.length < 3) {
          _leaderBoardItems.add(LeaderBoardUser());
        }
        return Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 350.0,
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
                              backgroundImage: AssetImage("assets/images/default-avatar.png"),
                              foregroundImage: modifiedImageNetwork(
                                _leaderBoardItems[1]?.avtUrl,
                              ),
                              backgroundColor: Colors.red,
                              radius: 27.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              (_leaderBoardItems[1].totalDistance / 1000)
                                  .toStringAsFixed(0) + ' km',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 70.0,
                              height: ((_leaderBoardItems[1].totalDistance * 1.0 /
                                  _leaderBoardItems[0].totalDistance * 1.0).isNaN ? 
                                  0.0 : _leaderBoardItems[1].totalDistance * 1.0 /
                                  _leaderBoardItems[0].totalDistance *  1.0) * 160.0,
                              color: Color(0xffFCA311),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "2nd",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffFFFFFF),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/images/default-avatar.png"),
                              foregroundImage: modifiedImageNetwork(
                                _leaderBoardItems[0]?.avtUrl,
                              ),
                              backgroundColor: Colors.red,
                              radius: 27,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (_leaderBoardItems[0].totalDistance / 1000.0)
                                      .toStringAsFixed(0) +
                                  ' km',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 70,
                              height: 160,
                              color: Color(0xffFCA311),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "1st",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffFFFFFF),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/images/default-avatar.png"),
                              foregroundImage: modifiedImageNetwork(
                                _leaderBoardItems[2].avtUrl,
                              ),
                              backgroundColor: Colors.red,
                              radius: 27,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (_leaderBoardItems[2].totalDistance / 1000)
                                      .toStringAsFixed(0) +
                                  ' km',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 70,
                              height: ((_leaderBoardItems[2].totalDistance * 1.0 /
                                  _leaderBoardItems[0].totalDistance * 1.0).isNaN ?
                                  0.0 : _leaderBoardItems[2].totalDistance * 1.0 /
                                   _leaderBoardItems[0].totalDistance * 1.0) * 160,
                              color: Color(0xffFCA311),
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                          buildList(ctxt, index, _leaderBoardItems)
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width*0.5,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(color: Colors.white,
                        //borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 5.0)
                        ],
                      ),
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
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 25),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 20,
                                          child: Text(
                                            _getUserRank(Provider.of<ModifiedUser>(context).uid, _leaderBoardItems),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red.shade800,
                                        backgroundImage: AssetImage("assets/images/default-avatar.png"),
                                        foregroundImage: modifiedImageNetwork(
                                          Provider.of<ModifiedUser>(context).avtUrl,
                                        ),
                                        radius: 30,
                                      ),
                                    ),
                                    Align(
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 5),
                                          child: Text(
                                            Provider.of<ModifiedUser>(context).name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ),
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
                                (Provider.of<ModifiedUser>(context).totalDistance / 1000)
                                  .toStringAsFixed(0) + ' km',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }, 
    );
  }
}
