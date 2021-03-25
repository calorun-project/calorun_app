import 'dart:math';

import 'package:calorun/gameengine/gamealertGE.dart';
import 'package:calorun/gameengine/gamedataGE.dart';

import 'cat.dart';
import 'inventory.dart';
import 'menu.dart';
import 'shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameHome extends StatefulWidget {
  GameHomeBuild createState() => GameHomeBuild();
}

class GameHomeBuild extends State<GameHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(-14860995),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/Bare.png"),
                        alignment: FractionalOffset.topCenter)),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/Floor.png"),
                        alignment: FractionalOffset.topCenter)),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Color(1845493759),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: IconButton(
                        icon: Image.asset("assets/images/Cabinet.png"),
                        iconSize: MediaQuery.of(context).size.height * 0.07,
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InventoryUI()))
                        },
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: IconButton(
                        icon: Image.asset("assets/images/CookBook.png"),
                        iconSize: MediaQuery.of(context).size.height * 0.07,
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Menu()));
                          if (Calo.weight >= Calo.maxWeight)
                            GameAlert.showFatDialog(context);
                        },
                      ),
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: IconButton(
                        icon: Image.asset("assets/images/Shop.png"),
                        iconSize: MediaQuery.of(context).size.height * 0.07,
                        onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ShopUI()))
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  height: MediaQuery.of(context).size.width * 0.43 * 5 / 3,
                  child: Image(
                    image: AssetImage("assets/images/Fridge.png"),
                  )),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  height: MediaQuery.of(context).size.width * 0.43 * 2 / 3,
                  child: Image(
                    image: AssetImage("assets/images/Stove.png"),
                  )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2 +
                  MediaQuery.of(context).size.width * 0.43,
              right: MediaQuery.of(context).size.width * 0.05,
              child: Container(
                  height: MediaQuery.of(context).size.width * 0.43 * 4 / 9,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Image(
                    image: AssetImage("assets/images/Locker.png"),
                  )),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.width * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image(
                      image: AssetImage("assets/images/Cat.gif"),
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Cat()))
                  },
                ))
          ],
        ));
  }
}
