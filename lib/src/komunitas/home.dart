import 'package:emphaty/src/komunitas/data/post_community.dart';
import 'package:emphaty/src/widgets/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _filterPressed() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FilterPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 40.0,
                width: 280.0,
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 15.0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                ),
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.slidersH,
                    color: Colors.grey[600],
                  ),
                  onPressed: () => _filterPressed()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 10.0, left: 10.0, bottom: 10.0, top: 20.0),
            child: Text(
              "hi",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          
          PostCommunity(),
        ],
      ),
    );
  }
}
