import 'package:calorun/gamedataGE.dart';
import 'package:calorun/kitchen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calorun/cookbookGE.dart';

import 'ingredientfoodGE.dart';

class Menu extends StatefulWidget {
  MenuBuild createState() => MenuBuild();
}

class MenuBuild extends State<Menu> {
  Cookbook _cookbook = new Cookbook();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Color(-220399),
              size: 32,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            "COOK BOOK",
            style: TextStyle(
                fontSize: 30,
                color: Color(-220399),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
              child: Text(
                "You have: ${_cookbook.cookList.length} / ${GameData.foods.length}",
                style: TextStyle(fontSize: 20, color: Color(-220399)),
              ),
            )),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: _cookbook.cookList.length,
                  itemBuilder: (context, index) {
                    return _food(_cookbook.cookList[index]);
                  }),
            ),
          ],
        ));
  }

  Widget _food(Food object) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding:
          EdgeInsets.fromLTRB(5, 5, MediaQuery.of(context).size.width * 0.1, 5),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.65,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(-220399), width: 3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(60)),
              ),
              child: ListView.builder(
                  itemCount: object.ingredient.length,
                  itemBuilder: (context, index) {
                    return _ingredient(
                        GameData.ingredients[object.ingredient[index]]);
                  }),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            child: Image(
              image: AssetImage(object.image),
              height: 64,
              width: 64,
            ),
          ),
          Visibility(
              visible: object.canCook(),
              child: Positioned(
                right: 0,
                child: IconButton(
                  icon: Image.asset("assets/images/cookIcon.png"),
                  iconSize: 32,
                  onPressed: () => {
                    if (object.canCook())
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Kitchen(foodID: object.id))),
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget _ingredient(Ingredient object) {
    return Container(
      height: 32,
      padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Image(
              image: AssetImage(object.image),
              height: 32,
              width: 32,
            ),
          ),
          Text(
            "${object.quantity()} / 1",
            style: TextStyle(fontSize: 15, color: Color(-220399)),
          )
        ],
      ),
    );
  }
}
