import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/data/user_data.dart';
import 'package:emphaty/src/models/target_bantuan.dart';
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
            child: Column(
              children: <Widget>[
                Container(
                  height: 110,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage(UserData.users[0].imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  UserData.users[0].username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Colors.blue[300],
                    ),
                    Text(
                      UserData.users[0].alamat,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                Text(
                  UserData.users[0].about,
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            alignment: Alignment(0, 0),
            child: buildListBantuan(),
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> getListBantuan() async {
    var res = await Network().getData('/post/target/user');
    var body = res.data;
    List<Widget> listWidget = List();
    if (body!=null && body['success'] == true) {
      for (int i = 0; i < body['data'].length; i++) {
        TargetBantuan target = TargetBantuan.fromJson(body['data'][i]);
        Widget widget =  Container(
          height: MediaQuery.of(context).size.width / 3.3,
          width: MediaQuery.of(context).size.width / 3.3,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(target.foto), fit: BoxFit.cover),
          ),
        );
        listWidget.add(widget);
      }
    }
    return listWidget;
  }

  Widget buildListBantuan() {
    Future data = getListBantuan();
    Widget widget = Text('Loading');
    data.then((value) {
      setState(() {
        widget = Column(
          children: value,
        );
      });
    });
    return widget;
  }
}
