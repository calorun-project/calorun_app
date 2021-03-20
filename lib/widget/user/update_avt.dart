import 'package:calorun/widget/header_navigate.dart';
import 'package:flutter/material.dart';

class UpdateAvatar extends StatefulWidget {
  @override
  _UpdateAvatarState createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigateHeader(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 30, ),
            Center(
              child: new AspectRatio(
                aspectRatio: 300 / 300,
                child: new Container(
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xff297373).withOpacity(0.75),
                      width: 10, //                   <--- border width here
                    ),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: new NetworkImage('https://i.stack.imgur.com/lkd0a.png'), // avt cu
                    )
                  ),
                ),
              ),
            ),

            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Color(0xffd6d6d6),
                  width: 150,
                  child: IconButton(
                    icon: Icon(Icons.add_photo_alternate),
                    onPressed: ()=>print("object")
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  color: Color(0xffd6d6d6),
                  width: 150,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt), 
                    onPressed: ()=>print("object")                    
                  ),
                ),
                
              ],                                          
            ),

            SizedBox(height: 15,),

            Container(
              child: ElevatedButton(
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
                      'Change',
                      style: TextStyle(color: Colors.white),
                    ),
                onPressed: (){
                  
                  print("hello");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Avatar changed")));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}