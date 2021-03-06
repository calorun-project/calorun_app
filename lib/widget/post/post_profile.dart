import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/modified_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostProfileWidget extends StatefulWidget {
  final Post post;
  final ModifiedUser owner;
  PostProfileWidget({this.post, this.owner});
  @override
  _PostProfileWidgetState createState() => _PostProfileWidgetState();
}

class _PostProfileWidgetState extends State<PostProfileWidget> {
  bool isLiked = false;
  int numLike = 0;
  String uid;

  @override
  Widget build(BuildContext context) {
    uid = Provider.of<String>(context);
    isLiked = widget.post.userLike.contains(uid);
    numLike = widget.post.userLike.length;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Container(
        color: Color(0xffF5F5F5),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/default-avatar.png"),
                    foregroundImage: modifiedImageNetwork(
                      widget.owner.avtUrl,
                    ),
                  ),
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.owner.name,
                          style: TextStyle(color: Color(0xff297373)),
                        ),
                        Text(
                          widget.post.timeAgo,
                          style: TextStyle(color: Colors.grey, fontSize: 9.0),
                        ),
                      ],
                    ),
                  ),
                  trailing: Visibility(
                    visible: uid == widget.post.ownerId,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Color(0xffc4c4c4),
                      ),
                      onPressed: () async {
                        await DatabaseServices(uid: uid)
                                .removePost(widget.post.pid, !(widget.post.imgUrl == null || widget.post.imgUrl == ''));
                      }
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 18.0),
                  child: Text(
                    widget.post.description,
                    style: TextStyle(color: Color(0xff297373)),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
            GestureDetector(
              onDoubleTap: () async {
                bool result = false;
                if (isLiked == false) {
                  result = await DatabaseServices(uid: uid)
                      .like(widget.post.ownerId, widget.post.pid);
                  if (result) {
                    widget.post.userLike.add(uid);
                    setState(() {
                      isLiked = widget.post.userLike.contains(uid);
                      numLike = widget.post.userLike.length;
                    });
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Something is wrong'),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                } else {                      
                  result = await DatabaseServices(uid: uid)
                      .dislike(widget.post.ownerId, widget.post.pid);
                  if (result) {
                    setState(() {
                      widget.post.userLike.remove(uid);
                      isLiked = widget.post.userLike.contains(uid);
                      numLike = widget.post.userLike.length;
                    });
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Something is wrong'),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                } 
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: widget.post.imgUrl == null || widget.post.imgUrl == '' ? 0 : 300,
                    decoration: BoxDecoration(                          
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        alignment: FractionalOffset.topCenter,
                        image: modifiedPostImageNetwork(
                            widget.post.imgUrl,
                          ),
                      )
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Visibility(
                  visible: widget.post.location != null && widget.post.location != '',
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.my_location,
                          color: Color(0xffFCA311),
                        ),
                        Text(
                          ' ' + widget.post.location,
                          style: TextStyle(color: Color(0xffFCA311))
                        ),
                      ],
                    ),
                  ),
                ),          
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                    GestureDetector(
                      onTap: () async {
                        bool result = false;
                        if (isLiked == false) {
                          result = await DatabaseServices(uid: uid)
                              .like(widget.post.ownerId, widget.post.pid);
                          if (result) {
                            widget.post.userLike.add(uid);
                            setState(() {
                              isLiked = widget.post.userLike.contains(uid);
                              numLike = widget.post.userLike.length;
                            });
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Something is wrong'),
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                          }
                        } else {                      
                          result = await DatabaseServices(uid: uid)
                              .dislike(widget.post.ownerId, widget.post.pid);
                          if (result) {
                            setState(() {
                              widget.post.userLike.remove(uid);
                              isLiked = widget.post.userLike.contains(uid);
                              numLike = widget.post.userLike.length;
                            });
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Something is wrong'),
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                          }
                        } 
                      },    
                      child: Row(
                        children: <Widget>[
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            size: 20.0,
                            color: Color(0xff297373),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              numLike.toString() +
                                  ((numLike > 1) ? " likes" : " like"),
                              style: TextStyle(color: Color(0xff297373)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
            