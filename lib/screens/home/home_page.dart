import 'package:calorun/models/user.dart';
import 'package:calorun/screens/home/leader_board.dart';
import 'package:calorun/screens/home/map.dart';
import 'package:calorun/screens/home/timeline.dart';
import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/header_navigate.dart';
import 'package:calorun/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<ModifiedUser>.value(
      value: DatabaseServices(uid: Provider.of<String>(context)).getUserData(),
      initialData: null,
      builder: (context, snapshot) {
        if (Provider.of<ModifiedUser>(context) == null) {
          return Waiting();
        }
        return Scaffold(
          appBar: navigate_header(context),
          body: PageView(
            children: <Widget>[
              Timeline(),
              Map(uid: Provider.of<String>(context), weight: Provider.of<ModifiedUser>(context).weight,),
              LeaderBoard(),
              Timeline(),
              Profile(Provider.of<String>(context)),
            ],
            controller: pageController,
            onPageChanged: onPageChanged,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: CupertinoTabBar(
            currentIndex: pageIndex,
            onTap: onTap,
            activeColor: Color(0xff297373),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.whatshot),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.run_circle_rounded),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.equalizer_rounded),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.games_rounded),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        );
      },
    );
  }
}
