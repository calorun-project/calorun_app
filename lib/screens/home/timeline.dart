//import 'dart:html';

import 'package:calorun/models/post.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/post.dart';
import 'package:flutter/material.dart';


class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {

  List<Post> listPost = [
    Post(
      pid: '123',
      location: 'hello',
      description: "hello",
      imgUrl: 'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
      ownerId: '1233',
      postTime: DateTime.now(),
      userLike: []

    ),
    Post(
      pid: '134',
      location: 'helloooo',
      description: "hellooooo",
      imgUrl: 'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
      ownerId: '1233',
      postTime: DateTime.now(),
      userLike: []

    ),

    Post(
      pid: '134',
      location: 'helloooo',
      description: "hellooooo",
      imgUrl: 'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
      ownerId: '1233',
      postTime: DateTime.now(),
      userLike: []

    ),

    Post(
      pid: '134',
      location: 'helloooo',
      description: "hellooooo",
      imgUrl: 'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
      ownerId: '1233',
      postTime: DateTime.now(),
      userLike: []

    ),
  ];


  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(),
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
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg',
                            ),
                          )
                    ),
                    Container(
                      height: 40, 
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'What \'s on your mind?',
                        ),
                        autofocus: false,
                      ),
                    )                  
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Padding(
                    //     padding: EdgeInsets.only(right: 35.0)
                    // ),

                    //Feature: Add Photo 
                    Container(
                      alignment: Alignment.center,
                      color: Colors.grey[200],
                      width: 200,
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          GestureDetector(
                            onTap: ()=>print('Open Photo'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo,
                                  size: 27.0,
                                  color: Color(0xff000000),
                                ),
                                Padding(padding: EdgeInsets.only(right: 5, left: 5)),
                                Text("Post a photo",style: TextStyle(color: Color(0xff14321D)),)
                              ],
                            )
                          ),
                        ],
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 10)),
                    Container(
                      color: Color(0xff90a6a6).withOpacity(0.4),
                      width: 200,
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          GestureDetector(
                            onTap: ()=>print('Posted'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send,
                                  size: 27.0,
                                  color: Color(0xff000000),
                                ),
                                Padding(padding: EdgeInsets.only(right: 5, left: 5)),
                                Text("Post",style: TextStyle(color: Color(0xff14321D)),)
                              ],
                            )
                          ),
                        ],
                      ) 
                    )

                  ],
                )
              ],
            )


          ),
          Container(
            child: ListView.builder(
              shrinkWrap:true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listPost.length,
              itemBuilder: (context, index) {
                // return ListTile(
                //   title: Text('${listPost[index].description}'),
                // );
                return Column(
                  children:  <Widget> [PostWidget(post: listPost[index]),]
                  //children: PostWidget(post: listPost[index]) ,
                );
              },
            ),
          ),
        ],
      ),
      )
    );
  }
}

//widget post, widget list bai dang



