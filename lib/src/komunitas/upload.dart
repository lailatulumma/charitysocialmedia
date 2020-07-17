import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/komunitas/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  var name;

  File imageFile;

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showCameraDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Buka Kamera!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Kamera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No Image Selected");
    } else {
      return Image.file(
        imageFile,
        width: 400.0,
        height: 400.0,
      );
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage('https://via.placeholder.com/140x100'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(child: Text("Bena Siana")),
            new RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  _upload();
                }
              },
              child: Center(
                child: Text(
                  _isLoading ? 'Proccessing...' : 'Upload',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Nama',
                ),
                validator: (nameValue) {
                  name = nameValue;
                  return null;
                },
              ),
              SizedBox(height: 40.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tanggal'),
                  SizedBox(width: 90.0),
                  Column(
                    children: <Widget>[
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(width: 20.0),
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                child: Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _decideImageView(),
                      RaisedButton(
                        onPressed: () {
                          _showCameraDialog(context);
                        },
                        child: Text("Tambahkan Foto"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _upload() async {
    setState(() {
      _isLoading = true;
    });
    MultipartFile file = await MultipartFile.fromFile(imageFile.path,
        filename: imageFile.path.split('/').last);
    var data = {
      'name': name,
      'held_on': selectedDate,
      'featured_image': file,
    };

    var res = await Network().authData(data, '/community/add/program');
    var body = res.data;
    if (body != null && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('target', json.encode(body['target']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Main()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
