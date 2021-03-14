//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:calorun/wrapper.dart';
import 'package:flutter/material.dart';
//import 'package:new_pro/pages/prelogin_page.dart';
//import 'package:new_pro/services/auth.dart';
//import 'package:new_pro/wrapper.dart';
//import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<String>.value(
    //   value: AuthServices().userCurrentId,
    //   initialData: null,
    //   child: MaterialApp(
    //     title: 'FlutterShare',
    //     debugShowCheckedModeBanner: false,
    //     home: Wrapper(),
    //   ),
    // );
    Wrapper();
  }
}
