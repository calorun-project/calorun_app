import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:calorun/shared/modified_image.dart';
import 'package:calorun/widget/user/watch_profile.dart';
import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  // final String currentUserId;
  // SearchUser({this.currentUserId});
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  List<SearchedUser> _listUser = [];
  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseServices.searchUser(searchKey),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return circularWaiting();
        _listUser = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(
              "Calorun",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Spantaran",
                fontSize: 50.0,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xff297373),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        border: OutlineInputBorder(),
                        hintText: 'Looking for someone?',
                      ),
                      autofocus: true,
                      onChanged: (val) {
                        setState(() => searchKey = val);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listUser.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(300),
                            ),
                          ),
                          tileColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WatchProfile(
                                  uid: _listUser[index].uid,
                                  // currentUserId: widget.currentUserId,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/default-avatar.png"),
                            foregroundImage: modifiedImageNetwork(
                              _listUser[index].avtUrl,
                            ),
                          ),
                          title: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WatchProfile(
                                    uid: _listUser[index].uid,
                                    // currentUserId: widget.currentUserId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: Text(
                                _listUser[index].name,
                                style: TextStyle(color: Color(0xff297373)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
