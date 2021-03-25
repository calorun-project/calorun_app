import 'gamedataGE.dart';
import 'ingredientfoodGE.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'shopGE.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool _window = true;

class ShopUI extends StatefulWidget {
  ShopBuild createState() => ShopBuild();
}

class ShopBuild extends State<ShopUI> {
  Shop _shop = new Shop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "SHOP",
            style: TextStyle(
                fontSize: 30,
                color: Color(-15580606),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(-14060685),
          leading: IconButton(
            icon: Icon(Icons.home, color: Color(-15580606)),
            iconSize: 32,
            tooltip: "Back to home",
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(3, 10, 0, 3),
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                            color: _window ? Colors.white : Color(-3750202),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image(
                          image: AssetImage("assets/images/Spices.png"),
                        ),
                      ),
                      onTap: () => _ChangeWindow(true),
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(3, 10, 0, 3),
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                            color: _window ? Color(-3750202) : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image(
                          image: AssetImage("assets/images/Gacha.png"),
                        ),
                      ),
                      onTap: () => _ChangeWindow(false),
                    ),
                    Spacer(),
                    Text(
                      "${Calo.tuna} ",
                      style: TextStyle(fontSize: 25, color: Color(-220399)),
                    ),
                    Image(
                      image: AssetImage("assets/images/Tuna.png"),
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Visibility(
                  child: _spicesBuild(),
                  visible: _window,
                ),
                Visibility(
                  child: _gachaBuild(),
                  visible: !_window,
                )
              ],
            )
          ],
        ));
  }

  void _ChangeWindow(window) {
    setState(() {
      _window = window;
    });
  }

  Widget _spicesBuild() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 5 / 6,
          ),
          itemCount: _shop.shopList.length - 1,
          itemBuilder: (context, index) {
            return _slot(_shop.shopList[index]);
          }),
    );
  }

  Widget _slot(Item object) {
    return Center(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
          width: MediaQuery.of(context).size.width * 0.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(-1710619),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Image(
                    image: AssetImage(object.image),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.4 * 3 / 8,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${object.getName()}",
                      style: TextStyle(
                          color: Color(-14060685),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${object.cost}",
                      style: TextStyle(
                        color: Color(-14060685),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () => _buy(object),
      ),
    );
  }

  bool _roll = true;

  Widget Toast(content, success) {
    return Container(
      height: 32,
      width: 200,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        color: success ? Color(-10158236) : Color(-44205),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 0),
      ),
      child: Center(
        child: Text("$content"),
      ),
    );
  }

  void _buy(Item object) //  fix,
  {
    setState(() {
      FToast fToast = FToast();
      fToast.init(context);
      if (Calo.tuna < object.cost) {
        fToast.showToast(
            child: Toast("You have not enough Tuna!", false),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 1));
      } else {
        fToast.showToast(
            child: Toast("Successfully purchase!", true),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 1));
        object.buy();
      }
    });
  }

  void _Click() {
    setState(() {
      if (_roll) {
        if (Calo.tuna >= GameData.gachaCost) {
          _roll = false;
          _ingredient = GameData.ingredients[Gacha(GameData.gachaCost).buy()];
        } else {
          FToast fToast = FToast();
          fToast.init(context);
          fToast.showToast(
              child: Toast("You have not enough Tuna!", false),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 1));
        }
      } else {
        _roll = true;
      }
    });
  }

  Ingredient _ingredient = GameData.ingredients[0];

  Widget _gachaBuild() {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.55,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: !_roll,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.005,
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 64,
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                      child: Text(
                        "${_ingredient.name}",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color(-14060685),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 20,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.black,
                      border: Border.all(color: Color(-14060685), width: 10),
                    ),
                  ),
                ),
                Visibility(
                    visible: !_roll,
                    child: Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      child: Image(
                        image: AssetImage(_ingredient.image),
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ))
              ],
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.5 + 30,
                height: MediaQuery.of(context).size.height * 0.2 + 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              )),
              ClipOval(
                  child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      gradient: _roll
                          ? LinearGradient(
                              colors: [
                                Color(-14655649),
                                Color(-13188671),
                                Color(-14655649),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.1, 0.4, 0.8],
                            )
                          : LinearGradient(
                              colors: [
                                Color(-4688128),
                                Color(-18882),
                                Color(-4688128),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.1, 0.4, 0.8],
                            )),
                  child: Center(
                    child: _roll
                        ? Text("ROLL",
                            style: TextStyle(
                                fontSize: 50,
                                color: Color(-5968660),
                                fontWeight: FontWeight.bold))
                        : Text(
                            "GET",
                            style: TextStyle(
                                fontSize: 50,
                                color: Color(-8366590),
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                onTap: _Click,
              ))
            ],
          ),
        )
      ],
    );
  }
}
