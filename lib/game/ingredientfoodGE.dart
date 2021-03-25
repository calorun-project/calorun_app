import 'dart:async';
import 'dart:math';
import 'gamedataGE.dart';
import 'dart:core';

class Pretreatment {
  String name;
  String image;

  Pretreatment(this.name) {
    this.image = GameData.pretreatImage + this.name.toString() + '.png';
  }
}

class Ingredient {
  int id;
  String name;
  String description;
  int rarity;
  List<Pretreatment> pretreatment;
  int cost;
  String image;

  int quantity() {
    return GameData.ingredientCount[this.id];
  }

  Ingredient(this.id, this.name, this.description, this.rarity,
      this.pretreatment, this.cost) {
    this.image = GameData.ingredientImage + this.id.toString() + '.png';
  }
}

class Food {
  int id;
  String name;
  String description;

  String instruction;

  List<int> ingredient;
  List<String> ingredientName;
  List<Pretreatment> pretreatment;
  List<int> cooktime; // second

  List<String> comments; // for rating 0-5 and 6-8 and 9-10

  int expBase;

  int requiredLevel;

  double weightBase;

  String image;

  Food(
      this.id,
      this.name,
      this.description,
      this.instruction,
      this.ingredient,
      this.ingredientName,
      this.pretreatment,
      this.cooktime,
      this.comments,
      this.expBase,
      this.requiredLevel,
      this.weightBase) {
    this.image = GameData.foodImage + this.id.toString() + '.png';
  }

  bool canCook() {
    int temp = 1;
    for (int i = 0; i < this.ingredient.length; i++) {
      temp *= GameData.ingredientCount[i];
    }
    return (temp != 0);
  }
}

class Process {
  int foodId;

  List<Ingredient> ingredient;
  List<Pretreatment> pretreatment;
  List<int> cooktime; // second
  List<Timer> timers;
  List<bool> timerOn;

  Process(int foodId) {
    this.foodId = foodId;
    this.ingredient = [
      for (int i = 0; i < GameData.foods[foodId].ingredient.length; i++)
        GameData.ingredients[GameData.foods[foodId].ingredient[i]]
    ];
    this.pretreatment = [
      for (int i = 0; i < GameData.foods[foodId].ingredient.length; i++)
        Pretreatment('')
    ];
    this.cooktime = [
      for (int i = 0; i < GameData.foods[foodId].ingredient.length; i++) 0
    ];
    this.timers = [
      for (int i = 0; i < GameData.foods[foodId].ingredient.length; i++)
        Timer(Duration(), () {})
    ];
    this.timerOn = [
      for (int i = 0; i < GameData.foods[foodId].ingredient.length; i++) false
    ];
  }

  void setIngredient(int ingredientIndex, int pretreatIndex) {
    this.pretreatment[ingredientIndex] =
        this.ingredient[ingredientIndex].pretreatment[pretreatIndex];
  }

  void setTimer(int index, Function func) {
    if (timerOn[index] == false) {
      timerOn[index] = true;

      timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
        // timers[index] = timer;
        cooktime[index]++;
        func();
      });
    }
  }

  int rating() {
    double temp = 0.0;
    for (int i = 0; i < this.ingredient.length; i++) {
      if (this.pretreatment[i].name ==
          GameData.foods[foodId].pretreatment[i].name)
        temp = temp + 5 / this.ingredient.length;

      var delta = this.cooktime[i] - GameData.foods[foodId].cooktime[i];
      if (delta < 0) delta = -delta;

      if (this.cooktime[i] > 0) {
        temp = temp + (5 / this.ingredient.length) * (1 / (1 + 0.5 * delta));
      }
    }
    return temp.round();
  }

  String comment() {
    List<String> commentList = GameData.foods[foodId].comments;

    int getRating = rating();

    if (getRating <= 5) return commentList[0];
    if (getRating <= 8) return commentList[1];
    return commentList[2];
  }

  int expGained() {
    int expBase = GameData.foods[foodId].expBase;

    int getRating = rating();

    return (1 / 2 * expBase * (1 + getRating / 10)).round();
  }

  double weightGained() {
    double weightBase = GameData.foods[foodId].weightBase;

    int getRating = rating();

    return (1 / 2 * weightBase * (1 + getRating / 10) * 10).round() / 10;
  }

  Future<List> finish() async {
    for (int i = 0; i < GameData.foods[foodId].ingredient.length; i++) {
      //timers[i].cancel();
      GameData.ingredientCount[GameData.foods[foodId].ingredient[i]]--;
    }
    String comment = this.comment();
    int ratingVal = this.rating();
    int expVal = this.expGained();
    double weightVal = this.weightGained();
    if (Calo.level < Calo.maxLevel) Calo.exp += expVal;
    while (Calo.exp >= Calo.maxExp()) {
      Calo.exp -= Calo.maxExp();
      Calo.level++;
      if (Calo.level >= Calo.maxLevel) Calo.exp = 0;
    }


    Calo.weight = min(Calo.weight + weightVal, Calo.maxWeight);

    return [comment, ratingVal, expVal, weightVal];
  }
}
