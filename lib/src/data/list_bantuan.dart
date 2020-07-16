import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/models/target_bantuan.dart';
import 'package:flutter/material.dart';

class ListBantuan extends StatefulWidget {
  @override
  _ListBantuanState createState() => _ListBantuanState();
}

class _ListBantuanState extends State<ListBantuan> {
  bool isLoaded = false;
  Widget loadingWidget = Text('Loading');
  Widget loadedWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListBantuan(),
    );
  }

  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  Future<List<Widget>> getListBantuan() async {
    var res = await Network().getData('/post/target/user');
    var body = res.data;
    List<Widget> listWidget = List();
    if (body != null && body['success'] == true) {
      for (int i = 0; i < body['data'].length; i++) {
        if (body['data'].length != null) {
          TargetBantuan target = TargetBantuan.fromJson(body['data'][i]);
          Widget widget = Container(
            height: MediaQuery.of(context).size.width / 3.2,
            width: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'http://192.168.8.100:8000/targets/' + target.foto),
                    fit: BoxFit.cover)),
          );
          listWidget.add(widget);
        } else {
          Widget text = Center(
            child: Text('Belum ada Post',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          );
          listWidget.add(text);
        }
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
          loadedWidget = widget = Wrap(
              // to apply margin in the cross axis of the wrap
              children: value);
        });
      });
    }
    return widget;
  }
}
