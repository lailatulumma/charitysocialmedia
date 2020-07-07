import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostContent extends StatefulWidget {
  final String userId;
  final String tanggal;

  PostContent({
    this.userId,
    this.tanggal,
  });

  @override
  _PostContentState createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  String nama;
  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        nama = user['name'];
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(bottom: 15.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/140x100')),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$nama',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.tanggal,
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 200.0,
              width: 380.0,
              child: Image.asset("assets/images/bapak.jpg", fit: BoxFit.cover),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 10.0, bottom: 10.0),
              child: Text(
                "[ RUJAK MBAH UYI❤️ ]",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Divider(
              color: Colors.black38,
              ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      'Comment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: (){
                    },
                  ),
                  InkWell(
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
