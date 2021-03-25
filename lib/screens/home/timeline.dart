import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/modified_image.dart';
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
                    child: Row(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            margin: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10, bottom: 15),
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/images/default-avatar.png"),
                              foregroundImage: modifiedImageNetwork(
                                Provider.of<ModifiedUser>(context).avtUrl ,
                              ),
                            )),
                        Spacer(),
                        GestureDetector(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.1, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Color(0xff6c807b)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                height: MediaQuery.of(context).size.width * 0.1,
                                width: MediaQuery.of(context).size.width * 0.65,
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
                                    reload: () {
                                      setState(() => null);
                                    },
                                  ),
                                ),
                              );
                            }),
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
                          PostWidget(post: posts[index],),
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
