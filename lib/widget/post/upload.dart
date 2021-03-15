import 'dart:io';

import 'package:calorun/shared/constants.dart';
import 'package:calorun/widget/header.dart';
import 'package:flutter/material.dart';
//import 'package:new_pro/widgets/header.dart';
//import 'package:new_pro/widgets/loading.dart';

class UploadWidget extends StatefulWidget {
  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File postImage;
  bool isUpLoading = false;
  String post_discription = "";
  TextEditingController descriptionController;
  TextEditingController locationController;
  getUserLocation(){

  }
  getImage(){

  }
  uploadAndSave(){
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          alignment: Alignment.center,
          //height: 200.0,
          //width: 300.0,
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff6c807b)),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Say something?'),
                  // validator: (val) =>
                  //     val.isEmpty ? 'What\'s up?' : null,
                  onChanged: (val) {
                    setState(() => post_discription = val);
                  },
                ),
              ),
              SizedBox(
                height: 20.00,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add_photo_alternate), onPressed: getImage),
                  IconButton(
                      icon: Icon(Icons.location_on), onPressed: getUserLocation),

                  //TODO: Return data about the location in this Text Widget
                  
                  Text(
                    "",
                    style: TextStyle(
                      color: Color(0xff297373).withOpacity(0.6),
                      fontSize: 14.0
                    ),
                  ), 
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xff297373).withOpacity(0.6);
                        return Color(0xff297373); // Use the component's default.
                      },
                    ),
                  ),
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  //TODO: Post
                },
              )
            ],
          ),
        ),  
      ) 
    );  
  } 
} 