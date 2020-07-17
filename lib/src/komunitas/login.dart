import 'dart:convert';

import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/komunitas/main.dart';
import 'package:emphaty/src/komunitas/signup.dart';
import 'package:emphaty/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginKomunitas extends StatefulWidget {
  @override
  _LoginKomunitasState createState() => _LoginKomunitasState();
}

class _LoginKomunitasState extends State<LoginKomunitas> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Hello',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 180.0, 0.0, 0.0),
                  child: Text(
                    'Komunitas',
                    style:
                        TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 180.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[400]),
                      ),
                    ),
                    validator: (emailValue) {
                      if (emailValue.isEmpty) {
                        return 'Please enter email';
                      }
                      email = emailValue;
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[400]),
                      ),
                    ),
                    obscureText: true,
                    validator: (passwordValue) {
                      if (passwordValue.isEmpty) {
                        return 'Please enter email';
                      }
                      password = passwordValue;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text(
                        'Kembali',
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blueAccent,
                      color: Colors.blue[400],
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _login();
                          }
                        },
                        child: Center(
                          child: Text(
                            _isLoading ? 'Proccessing...' : 'Login',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Dont have an Account?',
                        style: TextStyle(letterSpacing: 1.0),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => SignUpKomunitas()));
                        },
                        child: Text(
                          'Register Komunitas',
                          style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email_community': email, 'password': password};

    var res = await Network().authData(data, '/login/komunitas');
    var body = res.data;
    if (body!=null && body['success']==true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token',body['data']['token']);
      localStorage.setString('community', json.encode(body['community']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Main()),
      );
    } else {
      _showMsg(body['message']);
    }
  }
}
