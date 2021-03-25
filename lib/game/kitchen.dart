import 'evaluate.dart';
import 'gamedataGE.dart';
import 'ingredientfoodGE.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Kitchen extends StatefulWidget {
  int foodID;
  Kitchen({Key key, @required this.foodID}) : super(key: key);
  KitchenBuild createState() => KitchenBuild(foodID);
}

class KitchenBuild extends State<Kitchen> {
  int _cooked = 0;
  Process process;
  @override
  KitchenBuild(int index) {
    process = Process(index);
  }
  @override
  void dispose() {
    for (int i = 0; i < process.ingredient.length; i++) {
      process.timers[i].cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/table.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
                child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: CircularProgressIndicator(
                    value: _cooked / process.ingredient.length,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(-15728641)),
                    backgroundColor: Color(-1962934272),
                    strokeWidth: 10,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Image(
                    image: AssetImage(GameData.foods[process.foodId].image),
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
              ],
            )),
            Container(
              height: 64,
              alignment: Alignment.center,
              child: Text(
                "${GameData.foods[process.foodId].instruction}",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(-8845047),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              process.ingredient[_index].pretreatment.length,
                          itemBuilder: (context, index) {
                            return _pretreatment(index);
                          },
                        ),
                      ),
                      Spacer(),
                      _cook(),
                    ],
                  ),
                ),
                Visibility(
                    visible: _cooked == process.ingredient.length,
                    child: InkWell(
                        onTap: () async {
                          List temp = await process.finish();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Evaluate(
                                        evaluate: temp,
                                      )));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Color(-14060685),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color(-14060685),
                                Color(-13968421),
                                Color(-14060685)
                              ],
                              stops: [0.4, 1, 0.6],
                            ),
                            border:
                                Border.all(color: Color(-1710619), width: 5),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Text(
                            "FEED",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )))
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(-3223858), Colors.white],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, 0.5],
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: process.ingredient.length,
                itemBuilder: (context, index) {
                  return _ingredient(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  int _index = 0;

  void SetStateYolo() {
    this.setState(() {});
  }

  Widget _ingredient(index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () {
            _index = index;
            SetStateYolo();
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  color: _index == index ? Color(-220399) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(-1710619), width: 2)),
              child: Image.asset(process.ingredient[index].image)),
        ),
        Visibility(
            visible: process.timerOn[index],
            child: Text(
              "${process.cooktime[index]}",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _pretreatment(index) {
    print(process.pretreatment[index].image);
    return Visibility(
        visible: !process.timerOn[_index],
        child: InkWell(
          onTap: () {
            process.setIngredient(_index, index);
            print(process.ingredient[_index].pretreatment[index].name);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.height * 0.07,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              color: Color(-14060685),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Image(
              image: AssetImage(
                  process.ingredient[_index].pretreatment[index].image),
            ),
          ),
        ));
  }

  Widget _cook() {
    return Visibility(
        visible: !process.timerOn[_index],
        child: InkWell(
          onTap: () {
            process.setTimer(_index, SetStateYolo);
            _cooked++;
            SetStateYolo();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.height * 0.07,
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              color: Color(-14060685),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Image(image: AssetImage("assets/images/CookButton.png")),
          ),
        ));
  }
}
