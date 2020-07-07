import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/target_bantuan.dart';
import 'package:image_picker/image_picker.dart';

class FormUpload extends StatefulWidget {
  @override
  _FormUploadState createState() => _FormUploadState();
}

class _FormUploadState extends State<FormUpload> {
  bool _isLoading = false;
  final _target = TargetBantuan();
  final formKey = new GlobalKey<FormState>();

  var name,
      age,
      address,
      condition_economy,
      last_education,
      history_disease,
      description,
      job;

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
                maxLines: 5,
                decoration: new InputDecoration(
                  hintText: 'Bagaimana keadaan target bantuan?',
                  labelText: 'Deskripsi*',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Deskripsikan target Bantuan';
                  }
                  description = val;
                  return null;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Nama',
                ),
                validator: (nameValue) {
                  name = nameValue;
                  return null;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Age*',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Masukkan Umur';
                  }
                  age = val;
                  return null;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Alamat*',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Masukkan Alamat';
                  }
                  address = val;
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Text('Kategori Bantuan'),
              // new TextFormField(
              //   decoration: new InputDecoration(
              //     labelText: 'Disabilitas (Ya/Tidak)',
              //   ),
              //   validator: (val) {

              //     co = val;
              //     return null;
              //   },
              // ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Ekonomi Rendah (Ya/Tidak)',
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Bagaimana Kondisi Ekonomi';
                  }
                  condition_economy = val;
                  return null;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Penyakit Kronis',
                ),
                validator: (val) {
                  history_disease = val;
                  return null;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Putus Sekolah (Ya/Tidak)*',
                ),
                validator: (val) {
                  last_education = val;
                  return null;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Yatim/Piatu (Ya/Tidak)',
                ),
                validator: (val) {
                  job = val;
                  return null;
                },
              ),
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
    MultipartFile file = await MultipartFile.fromFile(imageFile.path,filename: imageFile.path.split('/').last);
    var data = {
      'name': name,
      'age': age,
      'address': address,
      'condition_economy': condition_economy,
      'last_education': last_education,
      'history_disease': history_disease,
      'description': description,
      'job': job,
      'featured_image': file,
      'category_id': 1,
    };

    var res = await Network().authData(data, '/post/add');
    var body = res.data;
    if (body != null && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('target', json.encode(body['target']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
