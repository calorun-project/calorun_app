import 'package:calorun/gameengine/gamedataGE.dart';
import 'package:calorun/screens/authenticate/prelogin.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calorun/screens/home/home_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String user = Provider.of<String>(context);
    print(Provider.of<String>(context));
    if (user == null) {
      return Prepage();
    } else {
      GameData.uid = user;
      return FutureBuilder(
        future: DatabaseServices(uid: user).getGameData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return circularWaiting();
          return Home();
        }
      );
    }
  }
}
