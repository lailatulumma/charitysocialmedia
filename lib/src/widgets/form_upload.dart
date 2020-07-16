import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emphaty/network/api.dart';
import 'package:emphaty/src/models/kategori.dart';
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
  final formKey = new GlobalKey<FormState>();

  final _kategori = Kategori();
  var name,
      address,
      description,
      job,
      orphaned,
      disability;

  String _valAges;
  List _listAges = ["Anak-anak", "Remaja", "Dewasa", "Lansia"];

  File imageFile;

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
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
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("Usia*", style: TextStyle()),
                  ),
                  Expanded(
                    child: new DropdownButton(
                      hint: Text("Pilih usia"),
                      value: _valAges,
                      items: _listAges.map((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valAges =
                              value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                        });
                      },
                    ),
                  )
                ],
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
              new CheckboxListTile(
                title: new Text('Penyakit Kronis'),
                value: _kategori.categories[Kategori.KategoriSakit],
                onChanged: (val) {
                  setState(
                    () => _kategori.categories[Kategori.KategoriSakit] = val,
                  );
                },
              ),
              new CheckboxListTile(
                title: new Text('Yatim Piatu'),
                value: _kategori.categories[Kategori.KategoriYatim],
                onChanged: (val) {
                  setState(
                    () => _kategori.categories[Kategori.KategoriYatim] = val,
                  );
                },
              ),
              new CheckboxListTile(
                title: new Text('Putus Sekolah'),
                value: _kategori.categories[Kategori.KategoriPutusSekolah],
                onChanged: (val) {
                  setState(
                    () => _kategori.categories[Kategori.KategoriPutusSekolah] = val,
                  );
                },
              ),
              CheckboxListTile(
                title: new Text('Disabilitas'),
                value: _kategori.categories[Kategori.KategoriDisability],
                onChanged: (val) {
                  setState(
                    () =>
                        _kategori.categories[Kategori.KategoriDisability] = val,
                  );
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Pekerjaan',
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
    MultipartFile file = await MultipartFile.fromFile(imageFile.path,
        filename: imageFile.path.split('/').last);
    var data = {
      'name': name,
      'age': _valAges,
      'address': address,
      'dropout': _kategori.categories[Kategori.KategoriPutusSekolah],
      'cronic_pain': _kategori.categories[Kategori.KategoriSakit],
      'disability': _kategori.categories[Kategori.KategoriDisability],
      'orphaned': _kategori.categories[Kategori.KategoriYatim],
      'description': description,
      'job': job,
      'featured_image': file,
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
