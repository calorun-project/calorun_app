import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/widget/user/watch_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final bool isOwner = true;
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
    ModifiedUser currentUser = Provider.of<ModifiedUser>(context);    
    isLiked = widget.post.userLike.contains(currentUser.uid);
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
                                currentUser: currentUser,
                              )),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
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
                                    currentUser: currentUser,
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
                      )
                    ),
                    trailing: Visibility(
                      visible: widget.isOwner,
                      child: IconButton(icon: Icon(Icons.close, color: Color(0xffc4c4c4),), onPressed: ()=> print("hello") ),
                    ),
                  
                ),

                // Body
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      if (isLiked == false) {
                        widget.post.userLike.add(currentUser.uid);
                        DatabaseServices(uid: currentUser.uid)
                            .like(widget.post.ownerId, widget.post.pid);
                      } else {
                        widget.post.userLike.remove(currentUser.uid);
                        DatabaseServices(uid: currentUser.uid)
                            .dislike(widget.post.ownerId, widget.post.pid);
                      }
                      isLiked = widget.post.userLike.contains(currentUser.uid);
                      numLike = widget.post.userLike.length;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        width: 300,
                        height: 300,
                        image: NetworkImage(
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
                                      widget.post.userLike.add(currentUser.uid);
                                      DatabaseServices(uid: currentUser.uid).like(
                                          widget.post.ownerId, widget.post.pid);
                                    } else {
                                      widget.post.userLike.remove(currentUser.uid);
                                      DatabaseServices(uid: currentUser.uid).dislike(
                                          widget.post.ownerId, widget.post.pid);
                                    }
                                    isLiked =
                                        widget.post.userLike.contains(currentUser.uid);
                                    numLike = widget.post.userLike.length;
                                  }),
                                },
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 20.0,
                              color: Color(0xff297373),
                            )),
                        Padding(padding: EdgeInsets.only(right: 20.0)),
                        GestureDetector(
                          onTap: () => print('ShowCommnets'),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            size: 20.0,
                            color: Color(0xff297373),
                          ),
                        )
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
