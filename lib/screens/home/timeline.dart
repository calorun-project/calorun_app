import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/widget/post/post.dart';
import 'package:calorun/widget/post/upload.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(context) {
    return FutureBuilder(
        future:
            DatabaseServices(uid: Provider.of<String>(context)).getPostList(),
        builder: (context, snapshot) {
          List<Post> posts = snapshot.data ?? <Post>[];
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
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  Provider.of<ModifiedUser>(context).avtUrl ==
                                          "None"
                                      ? "https://firebasestorage.googleapis.com/v0/b/calorunapp.appspot.com/o/default-avatar.jpg?alt=media&token=13b2a509-df44-47aa-80bb-a69a56f2f52f"
                                      : Provider.of<ModifiedUser>(context)
                                          .avtUrl,
                                ),
                              )),
                          GestureDetector(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xff6c807b)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 40,
                                  width: 300,
                                  child: Center(
                                    child: Text(
                                      "What\'s on your mind?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UploadWidget(
                                      uid: Provider.of<String>(context),
                                      reload: (Post post) {
                                        setState(() {
                                          posts.add(post);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Column(children: <Widget>[
                        PostWidget(post: posts[index], ),
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
