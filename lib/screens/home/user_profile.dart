
import 'package:calorun/models/post.dart';
import 'package:calorun/services/auth.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/post.dart';
import 'package:calorun/widget/post/upload.dart';
import 'package:calorun/widget/user/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
          
    Color c = const Color(0x297373);
    bool owner = true;
    Color deact = Colors.white;
    

    List<Post> listPost = [
      Post(
        pid: '123',
        location: 'hello',
        description: "hello",
        imgUrl: 'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
        ownerId: '1233',
        postTime: DateTime.now(),
        userLike: []

      ),
      Post(
        pid: '123',
        location: 'hello',
        description: "hello",
        imgUrl: 'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
        ownerId: '1233',
        postTime: DateTime.now(),
        userLike: []

      )
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        //appBar: header(),
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
                    'Username',
                    style: GoogleFonts.lato(
                        color: Colors.grey[800],
                        fontSize: 26,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding( 
                  padding: const EdgeInsets.only(right: 15.0, top: 8.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile())
                      );
                    },
                    child:  Container(
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
                          backgroundImage: NetworkImage(
                            'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                          ),
                        )
                    ),
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
                    'Scott Hamilton',
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
                    '   ngdang7891@gmail.com',
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
                    '174 cm',
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
                    '74 kg',
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
                    '  I love running',
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
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff297373), // background
                onPrimary: Color(0xff14213D), // foreground
              ),
              onPressed: AuthServices().signOut,
              child: Text(
                "Log out",
                style: TextStyle(color: Color(0xffFFFFFF)),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              child: ListView.builder(
                shrinkWrap:true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listPost.length,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   title: Text('${listPost[index].description}'),
                  // );
                  return Column(
                    children:  <Widget> [PostWidget(post: listPost[index]),]
                    //children: PostWidget(post: listPost[index]) ,
                  );
                },
              ),
            ),    

          ],             
        ),
        )
      );
    }
  }