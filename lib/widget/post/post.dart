import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/modified_image.dart';
import 'package:calorun/widget/user/watch_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  PostWidget({this.post});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  SimplifiedUser postOwner = SimplifiedUser();
  int numLike = 0;

  @override
  Widget build(BuildContext context) {
    String currentUserId = Provider.of<String>(context);    
    isLiked = widget.post.userLike.contains(currentUserId);
    numLike = widget.post.userLike.length;

    

    return FutureBuilder(
      future: DatabaseServices(uid: widget.post.ownerId).getSimplifiedUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) postOwner = snapshot.data;
        return Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Container(
            color: Color(0xffF5F5F5),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                // Head
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WatchProfile(
                                uid: widget.post.ownerId,
                                // currentUserId: currentUserId,
                              )),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/default-avatar.png"),
                    foregroundImage: modifiedImageNetwork(
                      postOwner.avtUrl,
                    ),
                  ),
                  title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WatchProfile(
                                    uid: widget.post.ownerId,
                                    // currentUserId: currentUserId,
                                  )),
                        );
                      },
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postOwner.name,
                                style: TextStyle(color: Color(0xff297373)),
                              ),
                              Text(
                                widget.post.timeAgo,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 9.0),
                              ),
                            ]),
                      )),
                ),
                // Body
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      if (isLiked == false) {
                        widget.post.userLike.add(currentUserId);
                        DatabaseServices(uid: currentUserId)
                            .like(widget.post.ownerId, widget.post.pid);
                      } else {
                        widget.post.userLike.remove(currentUserId);
                        DatabaseServices(uid: currentUserId)
                            .dislike(widget.post.ownerId, widget.post.pid);
                      }
                      isLiked = widget.post.userLike.contains(currentUserId);
                      numLike = widget.post.userLike.length;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: modifiedPostImageNetwork(
                          widget.post.imgUrl,
                        ),
                      )
                    ],
                  ),
                ),
                // Foot
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                        GestureDetector(
                            onTap: () => {
                                  setState(() {
                                    if (isLiked == false) {
                                      widget.post.userLike.add(currentUserId);
                                      DatabaseServices(uid: currentUserId).like(
                                          widget.post.ownerId, widget.post.pid);
                                    } else {
                                      widget.post.userLike.remove(currentUserId);
                                      DatabaseServices(uid: currentUserId).dislike(
                                          widget.post.ownerId, widget.post.pid);
                                    }
                                    isLiked =
                                        widget.post.userLike.contains(currentUserId);
                                    numLike = widget.post.userLike.length;
                                  }),
                                },
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 20.0,
                              color: Color(0xff297373),
                            )),
                        Padding(padding: EdgeInsets.only(right: 20.0)),
                        // GestureDetector(
                        //   onTap: () => print('ShowCommnets'),
                        //   child: Icon(
                        //     Icons.chat_bubble_outline,
                        //     size: 20.0,
                        //     color: Color(0xff297373),
                        //   ),
                        // )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            numLike.toString() +
                                ((numLike > 1) ? " likes" : " like"),
                            style: TextStyle(color: Color(0xff297373)),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            postOwner.name + ': ',
                            style: TextStyle(color: Color(0xff297373)),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.post.description,
                            style: TextStyle(color: Color(0xff297373)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
