import 'dart:io';
// ignore: unused_import
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

late File imageFile;

class BottomShhetWidget extends StatefulWidget {
  @override
  _BottomShhetWidgetState createState() => _BottomShhetWidgetState();
}

class _BottomShhetWidgetState extends State<BottomShhetWidget> {
  //var picker = ImagePicker();
  void takePhotoByCamera() async {
    var picker;
    var image = await picker.pickImage(source: ImageSource.camera) as File;

    setState(() {
      imageFile = image;
    });
  }

  void takePhotoByGallery() async {
    // ignore: deprecated_member_use
    var picker;
    File image =
        // ignore: deprecated_member_use
        await picker.pickImage(source: ImageSource.gallery) as File;
    setState(() {
      imageFile = image;
    });
  }

  void removePhoto() {
    setState(() {
      imageFile = Null as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 250.0,
      margin: EdgeInsets.only(left: 30.0, top: 25.0),
      child: Column(
        children: <Widget>[
          Text(
            "Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20.0, top: 20.0),
            child: Row(
              children: <Widget>[
                // ignore: deprecated_member_use
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: takePhotoByCamera,
                  label: Text("Camera"),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                ),
                // ignore: deprecated_member_use
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: takePhotoByGallery,
                  label: Text("Gallery"),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 40.0, top: 10.0),
            child: Row(
              children: <Widget>[
                // ignore: deprecated_member_use
                FlatButton.icon(
                  icon: Icon(Icons.delete),
                  onPressed: removePhoto,
                  label: Text("Remove"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
