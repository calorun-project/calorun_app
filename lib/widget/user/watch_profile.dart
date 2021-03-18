import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/widget/header.dart';
import 'package:flutter/material.dart';

class WatchProfile extends StatefulWidget {
  final String uid;
  WatchProfile({this.uid});
  @override
  _WatchProfileState createState() => _WatchProfileState();
}

class _WatchProfileState extends State<WatchProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: Profile(widget.uid),
    );
  }
}
