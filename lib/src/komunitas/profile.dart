import 'package:emphaty/src/komunitas/data/profile_komunitas_data.dart';
import 'package:emphaty/src/komunitas/data/program_komunitas.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 50.0),
        children: <Widget>[
          Container(
            child: ProfileKomunitas(),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: ProgramKomunitas()),
        ],
      ),
    );
  }
}