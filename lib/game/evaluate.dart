import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Evaluate extends StatefulWidget {
  List evaluate;
  Evaluate({Key key, @required this.evaluate}) : super(key: key);
  EvaluateBuild createState() => EvaluateBuild(this.evaluate);
}

class EvaluateBuild extends State<Evaluate> {
  List evaluate;
  EvaluateBuild(this.evaluate);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EVALUATE",
          style: TextStyle(color: Color(-220399), fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.home, color: Color(-220399)),
            iconSize: 32,
            tooltip: "Back to home",
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pop(context),
            },
          )
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    evaluate[1] > 2.5 ? Icons.star : Icons.star_border,
                    color: Color(-220399),
                    size: 30,
                  ),
                  Icon(
                    evaluate[1] > 5 ? Icons.star : Icons.star_border,
                    color: Color(-220399),
                    size: 50,
                  ),
                  Icon(
                    evaluate[1] > 7.5 ? Icons.star : Icons.star_border,
                    color: Color(-220399),
                    size: 30,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage("assets/cat.png"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Text("${evaluate[0]}", style: TextStyle(fontSize: 13, color: Colors.white),), //comment
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.25,
                  0,
                  MediaQuery.of(context).size.width * 0.25,
                  0),
              child: Row(
                children: [
                  Text(
                    "EXP: \n\nWeight: ",
                    style: TextStyle(fontSize: 20, color: Color(-220399)),
                  ),
                  Spacer(),
                  Text(
                    "+${evaluate[2]} \n\n+${evaluate[3]}",
                    style: TextStyle(fontSize: 20, color: Color(-13304012)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
