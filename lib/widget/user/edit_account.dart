import 'package:calorun/services/auth.dart';
import 'package:calorun/shared/loading.dart';
import 'package:calorun/widget/header.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  EditAccount({Key key}) : super(key: key);

  @override
  _EditAccount createState() => _EditAccount();
}

class _EditAccount extends State<EditAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                loading ? linearProgress() : Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => (val.length < 6)
                              ? 'A password must be at leasst 6 character'
                              : null,
                          autofocus: false,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
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
                        height: 40,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Confirm password",
                            border: OutlineInputBorder(),
                          ),
                          autofocus: false,
                          validator: (val) => (val.length < 6)
                              ? 'A password must be at leasst 6 character'
                              : ((val != password)
                                  ? 'Your comfirm password is different from the typed paswword'
                                  : null),
                          onChanged: (val) {
                            setState(() => confirmPassword = val);
                          },
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
                      bool result = await AuthServices().changePassword(password);
                      if (result == false) {
                        setState(() {
                          error =
                              'Failed';
                          loading = false;
                        });
                      } else {
                        loading = false;
                        Navigator.pop(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
