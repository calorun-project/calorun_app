import 'package:calorun/widget/header.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Username
                // Container(
                //   alignment: Alignment.center,
                //   height: 40, 
                //   //width: 300,
                //   child: Text("Username", style: TextStyle(fontSize: 17, color: Color(0xff297373)),),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20),                        
                  child: Container(
                            height: 40, 
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Username",
                                border: OutlineInputBorder(),
                                //hintText: 'Username',
                              ),
                              autofocus: false,
                            ),
                          ),
                )
              ],
            ),
            SizedBox(height: 20,),
            //Password
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   alignment: Alignment.center,
                //   height: 40, 
                //   //width: 300,
                //   child: Text("Password", style: TextStyle(fontSize: 17, color: Color(0xff297373)),),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20),                        
                  child: Container(
                            height: 40, 
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                //hintText: 'Username',
                              ),
                              autofocus: false,
                            ),
                          ),
                )
              ],
            ),
            SizedBox(height: 20,),
            //Confirm password
            //TODO: Check xem pass va confirm pass co giong nhau k?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   alignment: Alignment.center,
                //   height: 40, 
                //   //width: 300,
                //   child: Text("Confirm password", style: TextStyle(fontSize: 17, color: Color(0xff297373)),),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20),                        
                  child: Container(
                            height: 40, 
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Confirm password",
                                border: OutlineInputBorder(),
                                //hintText: 'Username',
                              ),
                              autofocus: false,
                            ),
                          ),
                )
              ],
            ),
            SizedBox(height: 20,),
            //Bio
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   alignment: Alignment.center,
                //   height: 40, 
                //   //width: 300,
                //   child: Text("Biography", style: TextStyle(fontSize: 17, color: Color(0xff297373)),),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20),                        
                  child: Container(
                            height: 60, 
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Biography",
                                border: OutlineInputBorder(),
                                //hintText: 'Username',
                              ),
                              autofocus: false,
                            ),
                          ),
                )
              ],
            ),
            SizedBox(height: 20,),
            
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
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  //TODO: Send
                },
              )

          ],
        ),
      )
    );
  }
}