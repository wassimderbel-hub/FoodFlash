import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Random random = new Random();

// ignore: non_constant_identifier_names
// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String ItemName;
  // ignore: non_constant_identifier_names
  final String ImagePath;
  // ignore: non_constant_identifier_names
  final double ItemPrice;
  // ignore: non_constant_identifier_names
  final String ItemDescription;
  // ignore: non_constant_identifier_names
  var ItemQuantity;

  OrderCard(
      // ignore: non_constant_identifier_names
      {required this.ItemName,
      // ignore: non_constant_identifier_names
      required this.ImagePath,
      // ignore: non_constant_identifier_names
      required this.ItemPrice,
      // ignore: non_constant_identifier_names
      required this.ItemDescription,
      // ignore: non_constant_identifier_names
      required this.ItemQuantity});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 75.0,
                width: 45.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD3D3D3)),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xFFD3D3D3),
                      ),
                      onTap: () async {
                        setState(() {
                          widget.ItemQuantity += 1;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('cart')
                            .doc(widget.ItemName)
                            .update({
                          'ItemName': widget.ItemName,
                          'ImagePath': widget.ImagePath,
                          'ItemDescription': widget.ItemDescription,
                          'ItemPrice': widget.ItemPrice,
                          'Quantity': FieldValue.arrayUnion([
                            {'id': random.nextInt(1000), 'Quantity': 1}
                          ])
                        });
                      },
                    ),
                    Text(
                      widget.ItemQuantity.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFD3D3D3),
                      ),
                      onTap: () async {
                        setState(() {
                          widget.ItemQuantity -= 1;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('cart')
                            .doc(widget.ItemName)
                            .update({
                          'ItemName': widget.ItemName,
                          'ImagePath': widget.ImagePath,
                          'ItemDescription': widget.ItemDescription,
                          'ItemPrice': widget.ItemPrice,
                          'Quantity': FieldValue.arrayUnion([
                            {'id': random.nextInt(1000), 'Quantity': -1}
                          ])
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 70.0,
                width: 50.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.ImagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        offset: Offset(0.0, 5.0),
                      ),
                    ]),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.ItemName,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.ItemPrice.toString(),
                    style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 25.0,
                    width: 180.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                widget.ItemDescription,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                onTap: () {
                  // ignore: unused_local_variable
                  final CollectionReference users =
                      FirebaseFirestore.instance.collection('users');
                  FirebaseFirestore.instance
                      .runTransaction((Transaction transaction) async {
                    // ignore: unused_local_variable
                    CollectionReference reference =
                        FirebaseFirestore.instance.collection('users');
                    var a = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .doc(widget.ItemName)
                        .get();
                    if (a.exists) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .doc(widget.ItemName)
                          .delete();
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
