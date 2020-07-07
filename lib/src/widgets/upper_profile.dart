import 'package:flutter/material.dart';

class UpperProfile extends StatefulWidget {
  @override
  _UpperProfileState createState() => _UpperProfileState();
}

class _UpperProfileState extends State<UpperProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage:  NetworkImage('https://via.placeholder.com/140x100')
          )
        ],
      ),
    );
  }
}