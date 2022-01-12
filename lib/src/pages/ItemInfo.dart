// ignore_for_file: deprecated_member_use, empty_constructor_bodies

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/Home.dart';
import '../pages/Order.dart';
import '../pages/Maps.dart';
import '../pages/Profile.dart';
import '../widget/InfoCard.dart';

class ScreenFood extends StatefulWidget {
  final String initialValue;
  final String initialValue1;
  final double initialValue2;
  final String initialValue3;

  ScreenFood(
      {Key? key,
      required this.initialValue,
      required this.initialValue1,
      required this.initialValue2,
      required this.initialValue3})
      : super(key: key);
  @override
  _ScreenFoodState createState() => _ScreenFoodState();
}

class _ScreenFoodState extends State<ScreenFood> {
  late String someString;
  late String someString1;
  late double someint;
  num totalsum = 0;
  late String someString3;
  int currentIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Order orderPage;
  late Maps mapsPage;
  late Profile profilePage;
  late InfoCard infoCard;

  @override
  void initState() {
    someString = widget.initialValue;
    someString1 = widget.initialValue1;
    someint = widget.initialValue2;
    someString3 = widget.initialValue3;
    super.initState();
    homePage = Home();
    orderPage = Order();
    mapsPage = Maps();
    profilePage = Profile();
    infoCard = InfoCard(
        ItemName: '$someString',
        ImagePath: '$someString1',
        ItemPrice: someint,
        ItemDescription: '$someString3');
    pages = [homePage, orderPage, mapsPage, profilePage];
    currentPage = infoCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            currentPage = pages[index];
          });
        },
        backgroundColor: Color.fromRGBO(255, 145, 77, 1),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("home"),
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                new Icon(Icons.shopping_cart),
                new Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(71, 240, 120, 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('totalcart')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var ds = snapshot.data!.docs;
                            num sum1 = 0;
                            for (int i = 0; i < ds.length; i++) {
                              totalsum = ds[i]['total'];
                            }

                            if (totalsum.isNaN) {
                              return Text('0');
                            } else {
                              return Text(
                                totalsum.toString(),
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ),
              ],
            ),
            // ignore: deprecated_member_use
            title: Text("Order"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.zoom_out_map),
            title: Text("Maps"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
        selectedItemColor: Color.fromRGBO(71, 240, 120, 1),
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
