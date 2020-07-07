import 'package:flutter/material.dart';

class UploadTopField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Upload",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}

