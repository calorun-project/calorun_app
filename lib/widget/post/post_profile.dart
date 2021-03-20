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

  Widget createPostHead(BuildContext context) {
    return ListTile(
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
    );
  }

  Widget createPostPicture(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          if (isLiked == false) {
            widget.post.userLike.add(uid);
            DatabaseServices(uid: uid)
                .like(widget.post.ownerId, widget.post.pid);
          } else {
            widget.post.userLike.remove(uid);
            DatabaseServices(uid: uid)
                .dislike(widget.post.ownerId, widget.post.pid);
          }
          isLiked = widget.post.userLike.contains(uid);
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
    );
  }

  Widget createPostFooter(BuildContext context) {
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
                    widget.post.userLike.add(uid);
                    DatabaseServices(uid: uid)
                        .like(widget.post.ownerId, widget.post.pid);
                  } else {
                    widget.post.userLike.remove(uid);
                    DatabaseServices(uid: uid)
                        .dislike(widget.post.ownerId, widget.post.pid);
                  }
                  isLiked = widget.post.userLike.contains(uid);
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
                widget.owner.name + ': ',
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
    uid = Provider.of<String>(context);
    isLiked = widget.post.userLike.contains(uid);
    numLike = widget.post.userLike.length;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Container(
        color: Color(0xffF5F5F5),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            createPostHead(context),
            createPostPicture(context),
            createPostFooter(context),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
