import 'package:flutter/material.dart';
import '../widget/ItemCatAll.dart';

class ViewAll extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<ViewAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromRGBO(255, 145, 77, 1),
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
              ItemCatAll(),
            ])));
  }
}
