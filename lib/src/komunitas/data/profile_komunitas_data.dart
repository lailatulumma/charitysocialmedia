import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/komunitas/data/komunitas_data.dart';
import 'package:flutter/material.dart';

class ProfileKomunitas extends StatefulWidget {
  @override
  _ProfileKomunitasState createState() => _ProfileKomunitasState();
}

class _ProfileKomunitasState extends State<ProfileKomunitas> {
  bool isLoaded = false;
  Widget loadingWidget = Text('Loading');
  Widget loadedWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildProfile(),
    );
  }

  Future<List<Widget>> getProfile() async {
    var res = await Network().getData('/community/profile');
    var body = res.data;
    List<Widget> listWidget = List();
    if (body != null && body['success'] == true) {
      print('sukkses');
      KomunitasData komunitas = KomunitasData.fromJson(body['data']);
      if (komunitas.foto != null) {
        Widget ava = Container(
          height: 110,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage('http://192.168.8.100:8000/communities/'+komunitas.foto),
              fit: BoxFit.cover,
            ),
          ),
        );
        listWidget.add(ava);
      } else {
        Widget noava = Container( 
          height: 110,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey[200],
          ),
        );
        listWidget.add(noava);
      }
      Widget name = Container(
          child: Text(
            komunitas.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ));
      if (komunitas.address != null) {
        Widget address = Container(
          child: Text(
            komunitas.address,
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        );
        listWidget.add(address);
      }
      listWidget.add(name);
    }
    return listWidget;
  }

  Widget buildProfile() {
    Widget widget;
    if (isLoaded) {
      widget = loadedWidget;
    } else {
      Future<List<Widget>> data = getProfile();
      data.then((value) {
        isLoaded = true;
        setState(() {
          loadedWidget = widget = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: value);
        });
      });
    }
    return widget;
  }
}
