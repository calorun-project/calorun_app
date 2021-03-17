import 'package:calorun/models/user.dart';
import 'package:calorun/screens/home/profile.dart';
import 'package:calorun/widget/header.dart';
import 'package:calorun/widget/user/other_user.dart';
import 'package:flutter/material.dart';


class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  List<SimplifiedUser> _listUser = [SimplifiedUser(), SimplifiedUser(), SimplifiedUser()];
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: header(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),                   
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                //alignment: Alignment.center,
                width: 400,
                child: TextField(
                  decoration: InputDecoration(  
                    labelText: "Search",
                    border: OutlineInputBorder(),
                    hintText: 'Looking for someone?',
                  ),
                  autofocus: true,
                ),
              ),
            ),            
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(                  //alignment: Alignment.center, 
                width: 400,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(300)),
                        ),
                        tileColor: Colors.transparent,
                        onTap: (){
                          print("hello");
                          
                          //TODO: thêm hàm get other user vào chỗ sau dấu =>
                          // Navigator.push(
                          //         context,
                          //         MaterialPageRoute(builder: (context) => OtherUser(this.uid)),
                          //       );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            _listUser[0].avtUrl,
                          ),
                        ),
                        title: GestureDetector(
                          onTap: (){
                            print("hello");

                            //TODO: thêm hàm get other user vào chỗ sau dấu =>
                            // Navigator.push(
                            //         context,
                            //         MaterialPageRoute(builder: (context) => print("hello"),
                            //       ),
                            // );
                          },
                          child: Container(
                            child: Text(
                              _listUser[0].firstName + " " + _listUser[0].lastName,
                              style: TextStyle(color: Color(0xff297373)),
                            ),
                          )
                        ),  
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}