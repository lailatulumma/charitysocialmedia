import 'dart:convert';
import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/data/list_bantuan.dart';
import 'package:emphaty/src/data/list_post.dart';
import 'package:emphaty/src/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/popular_post.dart';
import '../widgets/post_content.dart';
import '../widgets/nearest_post.dart';
import '../widgets/filter_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Data
import '../data/post_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name;
  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  List<PostData> _posts = posts;

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
              "hi, $name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          PopularPost(),
          SizedBox(
            height: 20.0,
          ),
          
          ListPost(),
        ],
      ),
    );
  }

  Widget _buildPostItem(PostData postData) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: PostContent(
        userId: postData.userId,
        tanggal: postData.tanggal,
      ),
    );
  }
}
