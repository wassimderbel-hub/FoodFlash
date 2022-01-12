// ignore_for_file: non_constant_identifier_names, deprecated_member_use, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodflash/src/widget/orderCard.dart';

class InfoCard extends StatefulWidget {
  final String ItemName;
  final String ImagePath;
  final double ItemPrice;
  final String ItemDescription;
  int quantity = 0;
  double total = 0;

  InfoCard(
      {required this.ItemName,
      required this.ImagePath,
      required this.ItemPrice,
      required this.ItemDescription});

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  final GlobalKey<ScaffoldState> _productScaffoldKey =
      new GlobalKey<ScaffoldState>();

  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  Map customDimension = new Map();
  int productQuantity = 0;
  double total = 0.0;
  var db = FirebaseFirestore.instance;

  setProductQuantity(String type) {
    setState(() {
      if (type == 'inc') {
        if (productQuantity != 20) {
          productQuantity = productQuantity + 1;
        }
      } else {
        if (productQuantity != 0) {
          productQuantity = productQuantity - 1;
        }
      }
    });
  }

  void showInSnackBar(String msg, Color color) {
    _productScaffoldKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            _productScaffoldKey.currentState!.removeCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 0.0),
                      colors: [
                        Color.fromRGBO(255, 145, 77, 1),
                        Color.fromRGBO(71, 240, 71, 0.8),
                      ],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.ItemName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              widget.ItemDescription,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 23,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      widget.ItemPrice.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 38,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      "per unit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.black),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.star,
                                    size: 15,
                                    color: Color.fromRGBO(71, 240, 71, 0.8)),
                                Icon(Icons.star,
                                    size: 15,
                                    color: Color.fromRGBO(71, 240, 71, 0.8)),
                                Icon(Icons.star,
                                    size: 15,
                                    color: Color.fromRGBO(71, 240, 71, 0.8)),
                                Icon(Icons.star,
                                    size: 15,
                                    color: Color.fromRGBO(71, 240, 71, 0.8)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ((MediaQuery.of(context).size.width - 175) / 2),
                    top: (MediaQuery.of(context).size.height + 175) / 5),
                child: Hero(
                  tag: "cakeitem",
                  child: ClipOval(
                    child: Container(
                      child: Image.asset(
                        widget.ImagePath,
                        fit: BoxFit.cover,
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Quantity",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 23),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(255, 145, 77, 1),
                        borderRadius: new BorderRadius.circular(100),
                      ),
                      width: 250,
                      height: 35,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: MaterialButton(
                                onPressed: () {
                                  setProductQuantity('dec');
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                                elevation: 4.0,
                              ),
                            ),
                            Text(
                              '$productQuantity',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                            Container(
                              child: MaterialButton(
                                onPressed: () {
                                  setProductQuantity('inc');
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                                elevation: 4.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Color.fromRGBO(71, 240, 71, 1),
                            child: Text("Add to Cart",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22)),
                            onPressed: () {
                              setState(() {
                                total += widget.ItemPrice * productQuantity;
                              });
                              // ignore: unused_local_variable
                              final CollectionReference users =
                                  FirebaseFirestore.instance
                                      .collection('users');
                              FirebaseFirestore.instance.runTransaction(
                                  (Transaction transaction) async {
                                // ignore: unused_local_variable
                                CollectionReference reference =
                                    FirebaseFirestore.instance
                                        .collection('users');
                                var a = await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('cart')
                                    .doc(widget.ItemName)
                                    .get();
                                if (a.exists) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('cart')
                                      .doc(widget.ItemName)
                                      .update({
                                    'ItemName': widget.ItemName,
                                    'ImagePath': widget.ImagePath,
                                    'ItemDescription': widget.ItemDescription,
                                    'ItemPrice': widget.ItemPrice,
                                    'Quantity': FieldValue.arrayUnion([
                                      {
                                        'id': random.nextInt(1000),
                                        'Quantity': productQuantity
                                      }
                                    ])
                                  });
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('cart')
                                      .doc(widget.ItemName)
                                      .set({
                                    'ItemName': widget.ItemName,
                                    'ImagePath': widget.ImagePath,
                                    'ItemDescription': widget.ItemDescription,
                                    'ItemPrice': widget.ItemPrice,
                                    'Quantity': FieldValue.arrayUnion([
                                      {
                                        'id': random.nextInt(1000),
                                        'Quantity': productQuantity
                                      }
                                    ])
                                  });
                                }
                              });
                            }))
                  ],
                ),
              ])),
        ]),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 1.3);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 1.3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
