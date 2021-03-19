import 'package:calorun/models/user.dart';
import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchProfile extends StatefulWidget {
  final String uid;
  final ModifiedUser currentUser;
  WatchProfile({this.uid, this.currentUser});
  @override
  _WatchProfileState createState() => _WatchProfileState();
}

class _WatchProfileState extends State<WatchProfile> {
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget.currentUser,
      child: Scaffold(
        appBar: header(),
        body: Profile(widget.uid),
      ),
    );
  }
}
