import 'gamedataGE.dart';
import 'ingredientfoodGE.dart';

class Cookbook {
  List<Food> cookList;

  Cookbook() {
    this.cookList = [];
    for (int i = 0; i < GameData.foods.length; i++) {
      if (Calo.level >= GameData.foods[i].requiredLevel)
        cookList.add(GameData.foods[i]);
    }
  }
}
