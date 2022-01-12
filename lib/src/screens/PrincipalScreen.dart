import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/Home.dart';
import '../pages/Order.dart';
import '../pages/Maps.dart';
import '../pages/Profile.dart';
import '../pages/Viewall.dart';

class PrincipalScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<PrincipalScreen> {
  num totalsum = 0;
  int currentIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Order orderPage;
  late Maps mapsPage;
  late Profile profilePage;
  late ViewAll viewallPage;

  @override
  void initState() {
    super.initState();
    homePage = Home();
    orderPage = Order();
    mapsPage = Maps();
    profilePage = Profile();
    pages = [homePage, orderPage, mapsPage, profilePage];
    currentPage = homePage;
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
            // ignore: deprecated_member_use
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
            // ignore: deprecated_member_use
            title: Text("Maps"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            // ignore: deprecated_member_use
            title: Text("Profile"),
          ),
        ],
        selectedItemColor: Color.fromRGBO(71, 240, 120, 1),
      ),
    );
  }
}
