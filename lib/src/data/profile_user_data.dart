import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileUserData extends StatefulWidget {
  @override
  _ProfileUserDataState createState() => _ProfileUserDataState();
}

class _ProfileUserDataState extends State<ProfileUserData> {
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
    var res = await Network().getData('/user/profile');
    var body = res.data;
    List<Widget> listWidget = List();
    if (body != null && body['success'] == true) {
      UserModel user = UserModel.fromJson(body['data']);
      if (user.avatar != null) {
        Widget ava = Container(
          height: 110,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage('http://192.168.8.100:8000/users/'+user.avatar),
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
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ));
      if (user.address != null) {
        Widget address = Container(
          child: Text(
            user.address,
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
