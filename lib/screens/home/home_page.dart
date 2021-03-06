import 'package:calorun/game/transition.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/screens/home/leader_board.dart';
import 'package:calorun/screens/home/map.dart';
import 'package:calorun/screens/home/timeline.dart';
import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:calorun/widget/user/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin<Home> {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ModifiedUser>.value(
      value: DatabaseServices(uid: Provider.of<String>(context)).userStream,
      initialData: null,
      builder: (context, snapshot) {
        ModifiedUser currentUser = Provider.of<ModifiedUser>(context);
        if (currentUser == null) {
          return circularWaiting();
        }
        return DefaultTabController(
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchUser(),
                      ),
                    );
                  },
                ),
              ],
              title: Text(
                "Calorun",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Spantaran",
                  fontSize: 50.0,
                ),
              ),
              centerTitle: true,
              backgroundColor: Color(0xff297373),
            ),
            body: TabBarView(
              controller: controller,
              children: <Widget>[
                Timeline(),
                Map(
                  uid: Provider.of<String>(context),
                  weight: Provider.of<ModifiedUser>(context).weight,
                ),
                LeaderBoard(),
                Transition(),
                Profile(Provider.of<String>(context)),
              ],
            ),
            bottomNavigationBar: TabBar(
              controller: controller,
              tabs: <Widget>[
                Icon(
                  Icons.whatshot,
                  color: Color(0xff297373),
                  size: 32,
                ),
                Icon(
                  Icons.run_circle_rounded,
                  color: Color(0xff297373),
                  size: 32,
                ),
                Icon(
                  Icons.equalizer_rounded,
                  color: Color(0xff297373),
                  size: 32,
                ),
                Icon(
                  Icons.games_rounded,
                  color: Color(0xff297373),
                  size: 32,
                ),
                Icon(
                  Icons.account_circle,
                  color: Color(0xff297373),
                  size: 32,
                ),
              ],
            ),
          ),
          length: 5,
        );
      },
    );
  }
}
