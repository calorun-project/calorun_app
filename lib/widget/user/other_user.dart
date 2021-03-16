import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/post/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherUser extends StatefulWidget {
  final String uid;

  OtherUser(this.uid);

  @override
  _OtherUserState createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  ModifiedUser user = ModifiedUser();

  Future<void> _loadUserProfile() async {
    user = await DatabaseServices(uid: widget.uid).getUserData();
  }

  @override
  void initState() {
    _loadUserProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: header(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      user.firstName + ' ' + user.lastName,
                      style: GoogleFonts.lato(
                          color: Colors.grey[800],
                          fontSize: 26,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
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
                            backgroundImage: NetworkImage(
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
                    child: Text(
                      'Name ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 37.0),
                    child: Text(
                      user.firstName + ' ' + user.lastName,
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
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Mail ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 37.0),
                    child: Text(
                      user.email,
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
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Height ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      user.height.toString() + ' cm',
                      style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34.0),
                    child: Text(
                      'Weight ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      user.weight.toString() + ' kg',
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
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Bio ',
                      style: GoogleFonts.lato(
                          color: Colors.grey[900],
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
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
              Container(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    child: GestureDetector(
                      child: Container(
                        color: Color(0xff297373),
                      ),
                      onTap: () => print('follow'),
                    ),
                  ),
                  Text(
                    "Folow",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              )),
              SizedBox(
                height: 30,
              ),
              StreamBuilder(
                stream: DatabaseServices(uid: widget.uid).userPosts,
                builder: (context, snapshot) {
                  List<Post> listPost = snapshot?.data ?? <Post>[];
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listPost.length,
                      itemBuilder: (context, index) {
                        return Column(children: <Widget>[
                          PostWidget(post: listPost[index]),
                        ]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
