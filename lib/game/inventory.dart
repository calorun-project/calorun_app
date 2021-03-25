import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calorun/inventoryGE.dart';

bool _visitable = false;
String _avatar = "assets/sugar.png";
String _name;
String _rank;
double _calories;
double _exp;
String _description;

class InventoryUI extends StatefulWidget {
  InventoryBuild createState() => InventoryBuild();
}

class InventoryBuild extends State<InventoryUI> {
  @override
  Widget build(BuildContext context) {
    Inventory _inventory = new Inventory();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "INVENTORY",
            style: TextStyle(fontSize: 30, color: Color(-15580606), fontWeight: FontWeight.bold),
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
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.width * 0.3 * 3 / 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(-1710619), width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _inventory.spiceList.length,
                        itemBuilder: (context, index) {
                          return _slot(_inventory.spiceList[index]);
                        },
                      ),
                    )),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(-1710619), width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        childAspectRatio: 4 / 5,
                      ),
                      itemCount: _inventory.ingredientList.length,
                      itemBuilder: (context, index) {
                        return _slot(_inventory.ingredientList[index]);
                      }),
                ))
              ],
            ),
            Center(
              child: Panel(),
            )
          ],
        ));
  }

  Widget _slot(IngredientInventory object) {
    return Center(
        child: InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
        width: MediaQuery.of(context).size.width * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   color: Colors.black,
          // ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.3 * 2 / 9,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Color(-11624288),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Center(child: Text("${object.getName()}", style: TextStyle(color: Color(
                  -1761411072),fontSize: 15, fontWeight: FontWeight.bold))),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Image(
                  image: AssetImage(object.image),
                  height: 64,
                  width: 64,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Text("+${object.getQuantity()}", style: TextStyle(color: Color(-1761411072),fontSize: 17, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
      onTap: () =>
          ShowPanel("${object.getName()}", object.image, "${object.getRarity()}", 125.0, 234.0, "${object.getDescription()}"),
    ));
  }

  void ShowPanel(name, avatar, rank, calories, exp, description) {
    setState(() {
      _name = name;
      _avatar = avatar;
      _rank = rank;
      _calories = calories;
      _exp = exp;
      _description = description;
      _visitable = true;
    });
  }

  void ClosePanel() {
    setState(() {
      _visitable = false;
    });
  }

  Widget Panel() {
    Color rarityColor;
    switch(_rank)
    {
      case "Basic":
        rarityColor = Color(-12791297);
        break;
      case "Common":
        rarityColor = Color(-12845253);
        break;
      case "Uncommon":
        rarityColor = Color(-236783);
        break;
      case "Rare":
        rarityColor = Color(-65279);
        break;
    }
    return Visibility(
        visible: _visitable,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5 * 4 / 3,
            decoration: BoxDecoration(
                color: Color(-1107296256),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(-220399),
                    ),
                    onPressed: ClosePanel,
                  ),
                ),
                Expanded(
                    child: Container(
                        height: 64,
                        width: 64,
                        alignment: Alignment.center,
                        child: Image(image: AssetImage(_avatar)))),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5 *  5 / 9,
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Column(
                    children: [
                      Text(
                        "$_name",
                        style: TextStyle(
                          color: Color(-220399),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "$_rank",
                        style: TextStyle(
                          color: rarityColor
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "$_description",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(-1579033),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
