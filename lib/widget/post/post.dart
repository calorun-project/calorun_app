import 'package:calorun/models/post.dart';
import 'package:calorun/models/user.dart';
import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/services/database.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final String currentUserId;
  final Post post;
  PostWidget({this.post, this.currentUserId});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  SimplifiedUser postOwner = SimplifiedUser();
  int numLike = 0;

  @override
  void initState() {
    _getPostInfo();
    super.initState();
  }

  Future<void> _getPostInfo() async {
    postOwner = await DatabaseServices(uid: widget.post.ownerId).getSimplifiedUser();
    setState(() {
      isLiked = widget.post.userLike.contains(widget.currentUserId);
      numLike = widget.post.userLike.length;
    });
  }

  createPostHead() {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile(widget.post.ownerId)),
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
              MaterialPageRoute(builder: (context) => Profile(widget.post.ownerId)),
            );
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postOwner.firstName + ' ' + postOwner.lastName,
                  style: TextStyle(color: Color(0xff297373)),
              ),
                Text(
                  widget.post.timeAgo,
                  style: TextStyle(color: Colors.grey, fontSize: 9.0),
                ),
            ]
             ),
          )),
    );
  }

  createPostPicture() {
    return GestureDetector(
      //TODO: Tăng like hộ bé ạ
      onDoubleTap: () => print('Liked'),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image(image: NetworkImage(
          postOwner.avtUrl,
        ),)
          /// của ĐĂng widget.post.imgUrl
          /// TODO: Lôi cái iamge xuống đi :<
        ],
      ),
    );
  }

  createPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
            GestureDetector(
                onTap: () => {
                      setState(() {
                        if (isLiked == false) {
                          widget.post.userLike.add(widget.currentUserId);
                          DatabaseServices(uid: widget.currentUserId)
                              .like(widget.post.ownerId, widget.post.pid);
                        } else {
                          widget.post.userLike.remove(widget.currentUserId);
                          DatabaseServices(uid: widget.currentUserId)
                              .dislike(widget.post.ownerId, widget.post.pid);
                        }
                        isLiked = widget.post.userLike.contains(widget.currentUserId);
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
                numLike.toString() + ((numLike > 1) ? " likes" : " like"),
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
                postOwner.firstName + ' ' + postOwner.lastName + ': ',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Container(
          color: Color(0xffF5F5F5),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10.0),
              createPostHead(),
              createPostPicture(),
              createPostFooter(),
              SizedBox(height: 20.0)
            ],
          ),
        ));
  }
}
