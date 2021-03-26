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
  bool isOwner = false;

  @override
  Widget build(BuildContext context) {
    String currentUserId = Provider.of<String>(context);
    isLiked = widget.post.userLike.contains(currentUserId);
    numLike = widget.post.userLike.length;
    isOwner = currentUserId == widget.post.ownerId;

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
                // Head
                Column(
                  children: <Widget> [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WatchProfile(
                              uid: widget.post.ownerId,
                              // currentUserId: currentUserId,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/default-avatar.png"),
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
                              ),
                            ),
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
                            ],
                          ),
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
                // Body
                GestureDetector(
                  onDoubleTap: () async {                    
                    bool result = false;
                    if (isLiked == false) {
                      result = await DatabaseServices(uid: currentUserId)
                          .like(widget.post.ownerId, widget.post.pid);
                      if (result) {
                        widget.post.userLike.add(currentUserId);
                        setState(() {
                          isLiked = widget.post.userLike.contains(currentUserId);
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
                      result = await DatabaseServices(uid: currentUserId)
                          .dislike(widget.post.ownerId, widget.post.pid);
                      if (result) {
                        setState(() {
                          widget.post.userLike.remove(currentUserId);
                          isLiked = widget.post.userLike.contains(currentUserId);
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
                        height: widget.post.imgUrl == null ||
                                widget.post.imgUrl == '' ? 0 : 300,
                        
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            alignment: FractionalOffset.topCenter,
                            image: modifiedPostImageNetwork(
                              widget.post.imgUrl,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Foot
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
                        Padding(
                          padding: EdgeInsets.only(top: 40.0, left: 18.0),
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool result = false;
                            if (isLiked == false) {
                              result = await DatabaseServices(uid: currentUserId)
                                  .like(widget.post.ownerId, widget.post.pid);
                              if (result) {
                                widget.post.userLike.add(currentUserId);
                                setState(() {
                                  isLiked = widget.post.userLike.contains(currentUserId);
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
                              result = await DatabaseServices(uid: currentUserId)
                                  .dislike(widget.post.ownerId, widget.post.pid);
                              if (result) {
                                setState(() {
                                  widget.post.userLike.remove(currentUserId);
                                  isLiked = widget.post.userLike.contains(currentUserId);
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
      },
    );
  }
}
