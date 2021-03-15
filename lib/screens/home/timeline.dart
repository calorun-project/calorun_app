import 'package:calorun/models/post.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/post.dart';
import 'package:calorun/widget/post/upload.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Post> listPost = <Post>[];

  @override
  Widget build(context) {
    return FutureBuilder(
        future:
            DatabaseServices(uid: Provider.of<String>(context)).getPostList(),
        builder: (context, snapshot) {
          return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 15, top: 10, bottom: 15),
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                                  ),
                                )),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xff6c807b)),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                height: 40,
                                width: 300,
                                //color: Color(0xffFFFFFF),
                                child: Center(
                                  child: Text(                                  
                                    "What\'s on your mind?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                )
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UploadWidget())
                                );
                              }
                            )                            
                          ],
                        ),
                      ],
                    )),
                    Container(
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
                    ),
                  ],
                ),
              ));
        });
  }
}

//widget post, widget list bai dang
