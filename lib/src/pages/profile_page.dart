import 'package:emphaty/src/data/profile_user_data.dart';
import 'package:emphaty/src/data/list_bantuan.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 50.0),
        children: <Widget>[
          Container(
            child: ProfileUserData(),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListBantuan()),
        ],
      ),
    );
  }
}
