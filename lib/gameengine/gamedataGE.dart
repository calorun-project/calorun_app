import 'dart:math';
import 'package:calorun/gameengine/gamealertGE.dart';
import 'package:flutter/cupertino.dart';

import 'ingredientfoodGE.dart';

class GameData {
  // Ingredients data
  static List<Ingredient> ingredients = [
    Ingredient(
        0, 'Salt', 'Salty. Eating eat alone is too much for Calo.', 0, [], 100),
    Ingredient(1, 'Sugar', 'Sweet.', 0, [], 100),
    Ingredient(2, 'Oil', 'Used for frying and stir-frying.', 0, [], 100),
    Ingredient(3, 'Egg', 'Round-shaped. Calo loves it.', 1,
        [Pretreatment('Break')], 0),
    Ingredient(4, 'Tomato', 'Juicy fruit. Rich in vitamin A and C.', 1,
        [Pretreatment('Cut')], 0),
    Ingredient(5, 'Spinach', 'Healthy and balanced food.', 2,
        [Pretreatment('Cut')], 0),
    Ingredient(6, 'Flour', 'Used for making sweet cakes.', 2, [], 0),
    Ingredient(7, 'Chicken', 'Rich in protein.', 3, [Pretreatment('Cut')], 0),
    Ingredient(8, 'Cream', 'Best served with sweet cakes and drinks.', 3, [], 0)
  ];
  static List<int> ingredientCount = [
    for (int i = 0; i < ingredients.length; i++) 0
  ];

  // Food data
  static List<Food> foods = [
    Food(
        0,
        'Omelette',
        'Simple yet delicious.',
        'Break the egg. Add the egg and salt altogether and cook for 10 secs.',
        [0, 3],
        ['Salt', 'Egg'],
        [Pretreatment(''), Pretreatment('Break')],
        [10, 10],
        [
          'Urrg. So bad.',
          'Quite good. I love eggs.',
          'Amazing. How can the omelette this delicious?'
        ],
        10,
        1,
        2.5),
    Food(
        1,
        'Tomato sauce',
        'Best served with spaghetti.',
        'Cut the tomato. Add the tomato and salt altogether and cook for 15 secs.',
        [0, 4],
        ['Salt', 'Tomato'],
        [Pretreatment(''), Pretreatment('Cut')],
        [15, 15],
        [
          'Urrg. Who ever eats tomato sauce alone?',
          'Wait. That\'s good.',
          'Amazing. Can I have this tomato sauce all the time'
        ],
        12,
        2,
        1.5),
    Food(
        2,
        'Stir-fried spinach',
        'A delicious meal for vegetarian.',
        'Pour a little of oil and heat for 5 secs, then add cut spinach and salt altogether and cook for 10 secs.',
        [2, 0, 5],
        ['Oil', 'Salt', 'Spinach'],
        [Pretreatment(''), Pretreatment(''), Pretreatment('Cut')],
        [15, 10, 10],
        [
          'Nope! I do not like vegetables!',
          'Quite good. I should eat some vegetables next time.',
          'Amazing! I love this.'
        ],
        15,
        3,
        2.5),
    Food(
        3,
        'Fried chicken',
        'A fast-food rich in protein.',
        'Heat the oil for 10 secs, then add cut chicken and cook for 15 secs.',
        [2, 7],
        ['Oil', 'Chicken'],
        [Pretreatment(''), Pretreatment('Cut')],
        [25, 15],
        [
          'Erhh. I cannot eat this thing!',
          'Quite good, I think.',
          'Can I get to eat this dish everyday?'
        ],
        20,
        4,
        5.0),
    Food(
        4,
        'Cake',
        'Sweet things for sweet lovers.',
        'Add sugar and flour altogether and cook for 30 secs. Add cream afterwards.',
        [1, 6, 8],
        ['Sugar', 'Flour', 'Cream'],
        [Pretreatment(''), Pretreatment(''), Pretreatment('')],
        [30, 30, 0],
        [
          'I love sweets, but not this thing.',
          'I want another taste of it.',
          'I do not love mackerel anymore. I love cakes.'
        ],
        25,
        5,
        7.0)
  ];

  static final int gachaCost = 200;
  static final String gachaImage = 'assets/images/gacha.png';
  static final String ingredientImage = 'assets/images/ingredient';
  static final String foodImage = 'assets/images/food';
  static final String pretreatImage = 'assets/images/pretreat';
}

class Calo {
  static int tuna = 0;
  static int maxTuna = 9999;

  static String name = 'Calo';

  static double height = 7.5;
  static double maxHeight = 15;

  static double weight = 2.0;
  static double maxWeight = 10.0;
  static double minWeight = 1.0;

  static int level = 1;
  static int maxLevel = 5;

  static int exp = 0;

  // Max exp at the current level
  static int maxExp() {
    return 10 + 10 * (level - 1) * (level - 1);
  }

  // Weight loss when run a distance with a speed
  static double weightLoss({double kilometers, double minutes}) {
    double pace = minutes / kilometers;
    return min(
        ((MoreMath.exponential(-0.2746 * pace) * 7.5 * kilometers) * 10)
                .round() /
            10,
        weight - minWeight);
  }

  // Tuna gained when run a distance with a speed
  static int tunaGained({double kilometers, double minutes}) {
    double pace = minutes / kilometers;
    return min(
        ((MoreMath.exponential(-0.2746 * pace) * 1000 * kilometers) / 10)
                .round() *
            10,
        maxTuna - tuna);
  }

  // Make Calo lose weight
  static void afterRun(
      {BuildContext context, double kilometers, double minutes}) {
    double lessWeight = weightLoss(kilometers: kilometers, minutes: minutes);
    int moreTuna = tunaGained(kilometers: kilometers, minutes: minutes);

    weight = weight - lessWeight;
    tuna = tuna + moreTuna;

    GameAlert.showAfterRunDialog(context, lessWeight, moreTuna);
  }
}

class MoreMath {
  static double exponential(double x) {
    return exp(x);
  }
}
