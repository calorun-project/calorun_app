import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:calorun/widget/post/post_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:calorun/shared/modified_image.dart';

class OtherUserProfile extends StatefulWidget {
  final String uid;

  OtherUserProfile(this.uid);

  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  ModifiedUser user = ModifiedUser();
  bool isFollow = true;
  TextEditingController buttonEdit = TextEditingController();
  String currentUserId;

  void followButton() {
    if (isFollow) {
      DatabaseServices(uid: currentUserId).unfollow(widget.uid);
      isFollow = false;
      buttonEdit.text = 'Follow';
    } else {
      DatabaseServices(uid: currentUserId).follow(widget.uid);
      isFollow = true;
      buttonEdit.text = 'Unfollow';
    }
  }

  @override
  Widget build(BuildContext context) {
    currentUserId = Provider.of<String>(context);
    return FutureBuilder(
      future: DatabaseServices(uid: widget.uid).getUserData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return circularWaiting();
        user = snapshot.data;
        isFollow = user.follower.contains(currentUserId);
        print(isFollow);
        buttonEdit.text = isFollow ? 'Unfollow' : 'Follow';
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
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(140)),
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/default-avatar.png"),
                                foregroundImage: modifiedImageNetwork(
                                  user.avtUrl,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.2,
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
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(
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
                          width: MediaQuery.of(context).size.width*0.2,
                          child: Text(
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
                        padding: const EdgeInsets.only(left: 0.0),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Text(
                            user.bio,
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
                    height: 20,
                  ),
                  Container(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffFCA311),
                            onPrimary: Color(0xff14213D),
                          ),
                          onPressed: followButton,
                          child: TextField(
                            textAlign: TextAlign.center,
                            enableInteractiveSelection: false,
                            enabled: false,
                            controller: buttonEdit,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder(
                    stream: DatabaseServices(uid: widget.uid).userPosts,
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
            ));
      },
    );
  }
}
