import 'package:flutter/material.dart';

class NearestCard extends StatelessWidget {
  final String imagePost;
  NearestCard({this.imagePost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              height: 140.0,
              width: 250.0,
              child: Image.asset(
                imagePost,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: 50.0,
              width: 250.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black12],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15.0)),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            child: Column(
              children: <Widget>[
                Text(
                  'Bantu Bapak kui',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Jl. Mulyosari',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
