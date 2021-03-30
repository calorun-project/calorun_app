import 'package:flutter/material.dart';

class GameAlert {
  static void showCustomDialog(
      BuildContext context, String title, String content) {
    // Buttons initializing
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showAfterRunDialog(
      BuildContext context, double weight, int tuna) {
    String title = "Congratulations!";
    String content = '';

    if (weight > 0) {
      content = content +
          "Calo the Cat has lost ${weight.toStringAsFixed(1)} kg while you are walking/running!";
      if (tuna > 0) {
        content = content + "\nYou have also obtained $tuna Tuna coins!";
      }
    } else {
      content = content + "You have obtained $tuna Tuna coins while running!";
    }

    showCustomDialog(context, title, content);
  }

  static void showFatDialog(BuildContext context) {
    String title = "Calo the Cat is too fat!";
    String content =
        "He cannot eat anymore! Let us run more so that he can lose some weight!";

    showCustomDialog(context, title, content);
  }
}
