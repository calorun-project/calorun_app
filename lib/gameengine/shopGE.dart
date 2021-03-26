import 'dart:math';
import 'package:calorun/services/database.dart';

import 'ingredientfoodGE.dart';
import 'gamedataGE.dart';

class Item {
  int cost;
  String image;

  Item();

  String getName() {
    return '';
  }

  String getDescription() {
    return '';
  }

  Future<int> buy() async {
    return -1;
  }
}

class Gacha extends Item {
  static List<int> prob = [0, 75, 95, 100];

  Gacha(int cost) {
    this.cost = cost;
    this.image = GameData.gachaImage;
  }

  int foodId() {
    Random rand = Random();

    int temp = rand.nextInt(100);
    int i = 0;
    for (i = 0; temp > prob[i + 1]; i++) {}

    List<Ingredient> tempList = [
      for (int j = 0; j < GameData.ingredients.length; j++)
        if (GameData.ingredients[j].rarity == i + 1) GameData.ingredients[j]
    ];

    return tempList[rand.nextInt(tempList.length * 10) % tempList.length].id;
  }

  @override
  String getName() {
    return 'Gacha';
  }

  @override
  String getDescription() {
    return 'You never know what is inside!';
  }

  @override
  Future<int> buy() async {
    Calo.tuna -= this.cost;
    int temp = foodId();
    GameData.ingredientCount[temp] += 1;

    await DatabaseServices(uid: GameData.uid).updateGameData();

    return temp;
  }
}

class FoodShop extends Item {
  int id;
  int cost;

  FoodShop(this.id, this.cost) {
    this.image = GameData.ingredients[this.id].image;
  }

  @override
  String getName() {
    return GameData.ingredients[this.id].name;
  }

  @override
  String getDescription() {
    return GameData.ingredients[this.id].description;
  }

  String getRarity() {
    int temp = GameData.ingredients[this.id].rarity;

    if (temp == 0)
      return "Basic";
    else if (temp == 1)
      return "Common";
    else if (temp == 2)
      return "Uncommon";
    else
      return "Rare";
  }

  @override
  Future<int> buy() async {
    Calo.tuna -= this.cost;
    GameData.ingredientCount[this.id] += 1;

    await DatabaseServices(uid: GameData.uid).updateGameData();

    return -1;
  }
}

class Shop {
  List<Item> shopList;

  Shop() {
    this.shopList = [];
    for (int i = 0; i < GameData.ingredients.length; i++) {
      if (GameData.ingredients[i].rarity == 0)
        shopList.add(
            FoodShop(GameData.ingredients[i].id, GameData.ingredients[i].cost));
    }

    shopList.add(Gacha(GameData.gachaCost));
  }
}
