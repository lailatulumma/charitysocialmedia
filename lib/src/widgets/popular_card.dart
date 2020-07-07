import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final String imagePost;
  final String titlePost;

  PopularCard({this.imagePost, this.titlePost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imagePost,
                height: 140.0,
                width: 250.0,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              titlePost,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
