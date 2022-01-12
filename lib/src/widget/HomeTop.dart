import 'package:flutter/material.dart';
import 'package:foodflash/src/pages/Contact.dart';

class HomeTop extends StatelessWidget {
  final textstyle = TextStyle(
    fontSize: 35.0,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What is ",
                style: textstyle,
              ),
              Text(
                "Available to buy ?",
                style: textstyle,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.contact_mail,
              size: 20.0,
              color: Color.fromRGBO(255, 145, 77, 1),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ReachUs()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              size: 20.0,
              color: Color.fromRGBO(255, 145, 77, 1),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
