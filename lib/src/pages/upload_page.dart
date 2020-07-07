import 'package:flutter/material.dart';
import '../widgets/upload_top_field.dart';
import '../widgets/form_upload.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            UploadTopField(),
            SizedBox(
              height: 15.0,
            ),
            FormUpload(),
          ],
        ),
      ),
    );
  }
}
