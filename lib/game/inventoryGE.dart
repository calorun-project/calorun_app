import 'ingredientfoodGE.dart';
import 'gamedataGE.dart';

class IngredientInventory {
  int id;
  String image;

  IngredientInventory(this.id) {
    this.image = GameData.ingredients[this.id].image;
  }

  String getName() {
    return GameData.ingredients[this.id].name;
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

  String getDescription() {
    return GameData.ingredients[this.id].description;
  }

  int getQuantity() {
    return GameData.ingredientCount[this.id];
  }
}

class Inventory {
  List<IngredientInventory> spiceList;
  List<IngredientInventory> ingredientList;

  Inventory() {
    this.spiceList = [];
    this.ingredientList = [];
    for (int i = 0; i < GameData.ingredientCount.length; i++) {
      if (GameData.ingredientCount[i] > 0) {
        if (GameData.ingredients[i].rarity > 0)
          ingredientList.add(IngredientInventory(i));
        else
          spiceList.add(IngredientInventory(i));
      }
    }
  }
}
