import 'package:calorun/models/user.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/shared/widget_resource.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final ModifiedUser user;
  EditProfile(this.user);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController bio = TextEditingController();
  String error = '';
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    firstName.text = widget.user.name.split(' ').first;
    lastName.text = widget.user.name.split(' ').last;
    weight.text = widget.user.weight.toStringAsFixed(2);
    height.text = widget.user.height.toStringAsFixed(2);
    bio.text = widget.user.bio;
    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      height: 60,
                      width: 300,
                      child: TextFormField(
                        controller: firstName,
                        decoration: InputDecoration(
                          labelText: "First name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => 
                          (value.isEmpty) ?
                          'Please enter your first name' :
                          ((RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9- ]').hasMatch(value)) ?
                          'Please enter a valid Name' :
                          null),
                        autofocus: false,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      height: 60,
                      width: 300,
                      child: TextFormField(
                        controller: lastName,
                        decoration: InputDecoration(
                          labelText: "Last name",
                          border: OutlineInputBorder(),
                          hintText: 'Last name',
                        ),
                        validator: (value) =>
                          (value.isEmpty) ?
                          'Please enter your first name' :
                          ((RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9- ]').hasMatch(value)) ?
                          'Please enter a valid Name' :
                          null),
                        autofocus: false,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      height: 60,
                      width: 300,
                      child: TextFormField(
                        controller: weight,
                        decoration: InputDecoration(
                          labelText: "Weight",
                          border: OutlineInputBorder(),
                          hintText: 'Weight',
                        ),
                        validator: (value) => 
                            (value.isEmpty) ?
                            'Please enter your weight' :
                            (!RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$').hasMatch(value)) ?
                            'Please enter a valid weight' :
                            (double.parse(value) < 0.0 || double.parse(value) > 999.0) ?
                            'Please enter a valid weight' : null,
                        autofocus: false,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      height: 60,
                      width: 300,
                      child: TextFormField(
                        controller: height,
                        decoration: InputDecoration(
                          labelText: "Height",
                          border: OutlineInputBorder(),
                          hintText: 'Height',
                        ),
                        validator: (value) =>
                            (value.isEmpty) ?
                            'Please enter your height' :
                            (!RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$').hasMatch(value)) ?
                            'Please enter a valid height' :
                            (double.parse(value) < 0.0 || double.parse(value) > 999.0) ?
                            'Please enter a valid height' : null,
                        autofocus: false,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      height: 100,
                      width: 300,
                      child: TextFormField(
                        controller: bio,
                        decoration: InputDecoration(
                          labelText: "Biography",
                          border: OutlineInputBorder(),
                          hintText: 'Biography',
                        ),
                        autofocus: false,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color(0xff297373).withOpacity(0.6);
                      return Color(0xff297373);
                    },
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    bool result = await DatabaseServices(uid: widget.user.uid)
                        .updateUserProfile(
                            firstName.text,
                            lastName.text,
                            double.parse(height.text),
                            double.parse(weight.text),
                            bio.text);
                    if (result == false) {
                      setState(() {
                        error = 'Something is wrong!';
                        loading = false;
                      });
                    } else {
                      loading = true;
                      Navigator.pop(context);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
