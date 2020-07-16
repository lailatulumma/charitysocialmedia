import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/models/target_bantuan.dart';
import 'package:flutter/material.dart';

class ListPost extends StatefulWidget {
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  bool isLoaded = false;
  Widget loadingWidget = Text('Loading');
  Widget loadedWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListBantuan(),
    );
  }

  Future<List<Widget>> getListBantuan() async {
    var res = await Network().getData('/post/all');
    var body = res.data;
    List<Widget> listWidget = List();
    if (body != null && body['success'] == true) {
      for (int i = 0; i < body['data'].length; i++) {
        TargetBantuan target = TargetBantuan.fromJson(body['data'][i]);
        Widget widget = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        'http://192.168.8.100:8000/targets/' + target.foto,
                      ),
                      fit: BoxFit.cover)),
            ),
            Text(
              target.deskripsi,
              style: TextStyle(fontSize: 12.0),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        );
        Widget ava = Row(
          children: <Widget>[
            CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/140x100')),
            SizedBox(
              width: 10.0,
            ),
            Text(target.namauser),
          ],
        );

        listWidget.add(ava);
        listWidget.add(widget);
      }
    }
    //
    return listWidget;
  }

  Widget buildListBantuan() {
    Widget widget;
    if (isLoaded) {
      widget = loadedWidget;
    } else {
      Future<List<Widget>> data = getListBantuan();
      data.then((value) {
        isLoaded = true;
        setState(() {
          loadedWidget = widget = Column(
              // to apply margin in the cross axis of the wrap
              children: value);
        });
      });
    }
    return widget;
  }
}
