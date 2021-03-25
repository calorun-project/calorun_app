import 'package:calorun/models/user.dart';
import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/services/auth.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchProfile extends StatefulWidget {
  final String uid;
  WatchProfile({this.uid});
  @override
  _WatchProfileState createState() => _WatchProfileState();
}

class _WatchProfileState extends State<WatchProfile> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<String>.value(
      value: AuthServices().userCurrentId,
      initialData: null,
      builder: (context, child) {
        String currentUserId = Provider.of<String>(context);
        if (currentUserId == null) {
          return circularWaiting();
        }
        return StreamProvider<ModifiedUser>.value(
          value: DatabaseServices(uid: currentUserId).userStream,
          initialData: null,
          builder: (context, child) {
            ModifiedUser currentUser = Provider.of<ModifiedUser>(context);
            if (currentUser == null) return circularWaiting();
            return Scaffold(
              appBar: header(),
              body: Profile(widget.uid),
            );
          },
        );
      },
    );
  }
}
