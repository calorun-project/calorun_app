import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/auth.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/modified_image.dart';
import 'package:calorun/widget/post/post_profile.dart';
import 'package:calorun/widget/user/edit_account.dart';
import 'package:calorun/widget/user/edit_profile.dart';
import 'package:calorun/widget/user/update_avt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ModifiedUser user = ModifiedUser();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<ModifiedUser>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 0.0),
                    width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                      user.name,
                      style: GoogleFonts.lato(
                          color: Colors.grey[800],
                          fontSize: 26,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(user)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFCA311),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 13, right: 20, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Edit',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                decoration: new BoxDecoration(color: Colors.white),
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: 108,
                        width: 101,
                        margin: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 25, bottom: 5),
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(140)),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/default-avatar.png"),
                          foregroundImage: modifiedImageNetwork(
                            user.avtUrl,
                          ),
                        )),

                    Positioned(
                      bottom: 54,
                      right: 20, //give the values according to your requirement
                      child: GestureDetector(
                        child: Material(
                          color: Color(0xffFCA311),
                          elevation: 10,
                          borderRadius: BorderRadius.circular(100),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          )),
                        onTap: ()=> Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateAvatar(currentUser: user,))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Container(
                    //color: Colors.blue,
                    width:  MediaQuery.of(context).size.width*0.2,
                    child: Text(
                      'Name ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    //color: Colors.blue,
                    width:  MediaQuery.of(context).size.width*0.65,
                    child:  Text(
                      user.name,
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Container(
                    width:  MediaQuery.of(context).size.width*0.2,
                    child:  Text(
                      'Mail ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Text(
                      user.email,
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text(
                      'Height ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text(
                      user.height.toString() + ' cm',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.1),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text(
                      'Weight ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text(
                      user.weight.toString() + ' kg',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text(
                      'Bio ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 0.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    user.bio,
                    style: GoogleFonts.lato(
                        color: Colors.grey[600],
                        fontSize: 14,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff297373),
                    onPrimary: Color(0xff14213D),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditAccount()));
                  },
                  child: Text(
                    "Change password",
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff297373),
                    onPrimary: Color(0xff14213D),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    AuthServices().signOut();
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
              stream: DatabaseServices(uid: user.uid).userPosts,
              builder: (context, snapshot) {
                List<Post> listPost = snapshot?.data ?? <Post>[];
                listPost.sort((Post a, Post b) {
                  return b.postTime.compareTo(a.postTime);
                });
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listPost.length,
                    itemBuilder: (context, index) {
                      return Column(children: <Widget>[
                        PostProfileWidget(
                          post: listPost[index],
                          owner: user,
                        ),
                      ]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
