import 'package:calorun/models/user.dart';
import 'package:calorun/widget/user/other_user_profile.dart';
import 'package:calorun/widget/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final String uid;

  Profile(this.uid);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<ModifiedUser>(context).uid == widget.uid
        ? UserProfile()
        : OtherUserProfile(widget.uid);
  }
}
