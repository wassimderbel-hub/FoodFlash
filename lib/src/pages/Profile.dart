import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodflash/src/pages/EditProfile.dart';
// ignore: unused_import
import '../widget/bottomSheetWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  final imagePicker = ImagePicker();
  File? imageFile;

  Future pickImage() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
      print(imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: followButton(),
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Color.fromARGB(200, 251, 190, 151)),
            clipper: GetClipper(),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 6.0,
            // left: 76.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageFile == null
                              ? AssetImage("../assets/images/profile.jpg")
                              : FileImage(imageFile!) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(80.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Color.fromARGB(100, 251, 190, 151),
                            offset: Offset(5.0, 6.0),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 20.0,
                      child: InkWell(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 28.0,
                        ),
                        onTap: () => pickImage(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 50.0,
                    ),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final userData = snapshot.data!.data();

                            return Text(
                              '${userData!['username']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return (Center(child: CircularProgressIndicator()));
                          }
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.create,
                        size: 18.0,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 50.0,
                    ),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final userData = snapshot.data!.data();
                            if (userData!['function'] != null) {
                              return Text(
                                '${userData['function']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              );
                            } else {
                              return Text(
                                'Your function',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                Divider(
                  height: 15.0,
                  color: Colors.black,
                ),
                Container(
                  width: 350.0,
                  height: 54.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final userData = snapshot.data!.data();
                                  if (userData!['discounts'].isNaN) {
                                    return Text('0');
                                  } else {
                                    return Text(
                                      userData['discounts'].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "Discounts",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: 70.0,
                        color: Colors.black,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "0",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "Ratings",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: 70.0,
                        color: Colors.black,
                      ),
                      Column(
                        children: <Widget>[
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final userData = snapshot.data!.data();
                                  if (userData!['discounts'].isNaN) {
                                    return Text('0');
                                  } else {
                                    return Text(
                                      userData['discounts'].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "Orders",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 20.0,
                  color: Colors.black,
                ),
                Container(
                  color: Color.fromARGB(200, 251, 190, 151),
                  width: MediaQuery.of(context).size.width,
                  height: 130.0,
                  child: Card(
                    // color: Colors.amber,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "About",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final userData = snapshot.data!.data();
                                  if (userData!['bio'] != null) {
                                    return Text(
                                      '${userData['bio']}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      'You can add here a description about yourself ',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 2.2);
    path.lineTo(size.width + 125.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
