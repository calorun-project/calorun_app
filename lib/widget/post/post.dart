

import 'package:calorun/models/post.dart';
import 'package:calorun/widget/user/other_user.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  PostWidget({this.post});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {


// TODO: Check xem user có like post chưa?
bool isLiked = false;
bool uplike = false;
int num =0;

void _handleTap() {
    setState(() {
      isLiked = !isLiked;
    });
}



createPostHead(){
  return ListTile(
    onTap: (){
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtherUser()),
            );
    },

    leading: CircleAvatar(
      backgroundImage: NetworkImage(
                          'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                        ),
    ),
    title: GestureDetector(
      onTap: (){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtherUser()),
              );
      },
      child: Container(
        child: Text(
          "Username",
          style: TextStyle(color: Color(0xff297373)),
        ),
      )
    ),  
  );
}

createPostPicture(){
  return GestureDetector(
    onDoubleTap: ()=>print('Liked'),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
            height: 200,
          ),
      ],
    ),
  );
}

createPostFooter(){

  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0, left: 20.0) 
          ), 
          GestureDetector(
            onTap: ()=> {
              setState((){
                if(isLiked == false){
                  isLiked = true;
                  num++;
                }
                else{
                  isLiked = false;
                  num--;
                }
              })
            },
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              size: 20.0,
              color: Color(0xff297373),
            )
          ),
          
          Padding(
            padding: EdgeInsets.only(right: 20.0)
          ),
          GestureDetector(
            onTap: ()=>print('ShowCommnets'),
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
              //TODO: Like count
              
               num.toString() + " like",
              style: TextStyle(
                color: Color(0xff297373)
              ),
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
              //TODO
              "Username: ",
              style: TextStyle(color: Color(0xff297373)),
            ),
          ),
          Expanded(
            child: Text(
              //TODO
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
      )
    );
  }
}
