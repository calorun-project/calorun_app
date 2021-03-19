import 'package:calorun/widget/header.dart';
import 'package:flutter/material.dart';


class UpdateAvatar extends StatefulWidget {
  @override
  _UpdateAvatarState createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 70, ),
            Center(
              child: new AspectRatio(
                aspectRatio: 300 / 300,
                child: new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: new NetworkImage('https://i.stack.imgur.com/lkd0a.png'), //TODO: Lấy hình
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
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
                      'Change',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (){
                      print("save");
                      //TODO: Lưu hình
                    },
                  ),
          ],
        ),
      ),
    );
  }
}