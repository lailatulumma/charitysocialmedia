import 'dart:convert';

import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/komunitas/login.dart';
import 'package:emphaty/src/models/kategori.dart';
import 'package:emphaty/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpKomunitas extends StatefulWidget {
  @override
  _SignUpKomunitasState createState() => _SignUpKomunitasState();
}

class _SignUpKomunitasState extends State<SignUpKomunitas> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _kategori = Kategori();

  var name;
  var email;
  var phone;
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
        body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 70.0, 0.0, 0.0),
                    child: Text(
                      'Signup Komunitas',
                      style: TextStyle(
                          fontSize: 70.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(255.0, 50.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[400]),
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
                        labelText: 'Nama Komunitas',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[400]),
                        ),
                      ),
                      validator: (nameValue) {
                        if (nameValue.isEmpty) {
                          return 'Please enter your name';
                        }
                        name = nameValue;
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email Komunitas',
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Telepon',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[400]),
                        ),
                      ),
                      validator: (phonenumber) {
                        if (phonenumber.isEmpty) {
                          return 'Please enter phone number';
                        }
                        phone = phonenumber;
                        return null;
                      },
                    ),
                    new CheckboxListTile(
                      title: new Text('Penyakit Kronis'),
                      value: _kategori.categories[Kategori.KategoriSakit],
                      onChanged: (val) {
                        setState(
                          () => _kategori.categories[Kategori.KategoriSakit] =
                              val,
                        );
                      },
                    ),
                    new CheckboxListTile(
                      title: new Text('Yatim Piatu'),
                      value: _kategori.categories[Kategori.KategoriYatim],
                      onChanged: (val) {
                        setState(
                          () => _kategori.categories[Kategori.KategoriYatim] =
                              val,
                        );
                      },
                    ),
                    new CheckboxListTile(
                      title: new Text('Putus Sekolah'),
                      value:
                          _kategori.categories[Kategori.KategoriPutusSekolah],
                      onChanged: (val) {
                        setState(
                          () => _kategori
                              .categories[Kategori.KategoriPutusSekolah] = val,
                        );
                      },
                    ),
                    CheckboxListTile(
                      title: new Text('Disabilitas'),
                      value: _kategori.categories[Kategori.KategoriDisability],
                      onChanged: (val) {
                        setState(
                          () => _kategori
                              .categories[Kategori.KategoriDisability] = val,
                        );
                      },
                    ),
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
                          return 'Please enter some text';
                        }
                        password = passwordValue;
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
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
                              _register();
                            }
                          },
                          child: Center(
                            child: Text(
                              _isLoading ? 'Proccessing...' : 'Register',
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
                          'Already have an account?',
                          style: TextStyle(letterSpacing: 2.0),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => LoginKomunitas()));
                          },
                          child: Text(
                            'Login Komunitas',
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
        ));
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email_community': email,
      'password': password,
      'phone_community': phone,
      'dropout': _kategori.categories[Kategori.KategoriPutusSekolah],
      'cronic_pain': _kategori.categories[Kategori.KategoriSakit],
      'disability': _kategori.categories[Kategori.KategoriDisability],
      'orphaned': _kategori.categories[Kategori.KategoriYatim],
      'name_community': name,
    };

    var res = await Network().authData(data, '/register/komunitas');
    var body = res.data;
    if (body != null && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['data']['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => LoginKomunitas()),
      );
    } else {
      _showMsg(body['message']);
    }
  }
}
