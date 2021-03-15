import 'package:calorun/screens/authenticate/login.dart';
import 'package:calorun/screens/home/timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState(){
    super.initState();
    pageController = PageController();
  } 

  @override
  void dispose() { 
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex){
    setState(() {
          this.pageIndex = pageIndex;
        });
  }

  onTap(int pageIndex){
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          Timeline(),
          Timeline(),
          Timeline(),
          Timeline(),
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
          BottomNavigationBarItem(icon: Icon(Icons.whatshot),),
          BottomNavigationBarItem(icon: Icon(Icons.run_circle_rounded),),
          BottomNavigationBarItem(icon: Icon(Icons.equalizer_rounded),),
          BottomNavigationBarItem(icon: Icon(Icons.games_rounded),),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),),
        ],
      ),
    );
  }
}