import 'dart:io';
import 'package:calorun/shared/widget_resource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calorun/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:calorun/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Future<bool> checkInternet() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       return true;
  //     }
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<String>.value(
      value: AuthServices().userCurrentId,
      initialData: null,
      child: MaterialApp(
        title: 'Calorun',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
