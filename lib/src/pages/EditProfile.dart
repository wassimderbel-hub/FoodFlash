import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodflash/src/screens/PrincipalScreen.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username = '';
  String address = '';
  String phone = '';
  String job = '';
  String about = '';
  var checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(255, 145, 77, 1)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 18),
        _Bodytext('Username'),
        _formfullname(),
        _Bodytext('Address'),
        _formaddress(),
        _Bodytext('Phone Number'),
        _formphoneNumber(),
        _Bodytext('About'),
        _formbio(),
        _Bodytext('Job'),
        _formfunc(),
        SizedBox(height: 30),
        Container(
            height: 36,
            width: 300,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 145, 77, 1)),
                onPressed: () async {
                  // ignore: unused_local_variable
                  final CollectionReference users =
                      FirebaseFirestore.instance.collection('users');
                  FirebaseFirestore.instance
                      .runTransaction((Transaction transaction) async {
                    // ignore: unused_local_variable
                    CollectionReference reference =
                        FirebaseFirestore.instance.collection('users');

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'username': username,
                      'Address': address,
                      'bio': about,
                      'phoneNumber': phone,
                      'function': job,
                    });
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrincipalScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      backgroundColor: Color.fromARGB(100, 71, 240, 71),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Profile edited successfully !',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      )));
                },
                child: Text("Confirm",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      color: Colors.white,
                    )))),
        SizedBox(
          height: 10,
        ),
      ])),
    ));
  }

  _formfullname() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 5),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              username = value.toString().trim();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'New username ?',
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: Color.fromRGBO(255, 145, 77, 1),
          )
        ],
      ),
    );
  }

  _formaddress() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 5),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              address = value.toString().trim();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your Address (home/work)',
              prefixIcon: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: Color.fromRGBO(255, 145, 77, 1),
          )
        ],
      ),
    );
  }

  _formphoneNumber() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 5),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              phone = value.toString().trim();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your phone Number (country code + number)',
              prefixIcon: Icon(
                Icons.contact_phone,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: Color.fromRGBO(255, 145, 77, 1),
          )
        ],
      ),
    );
  }

  _formbio() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 5),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              about = value.toString().trim();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Anything about you :)',
              prefixIcon: Icon(
                Icons.text_snippet_sharp,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: Color.fromRGBO(255, 145, 77, 1),
          )
        ],
      ),
    );
  }

  _formfunc() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 5),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              job = value.toString().trim();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Your job',
              prefixIcon: Icon(
                Icons.home_work,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: Color.fromRGBO(255, 145, 77, 1),
          )
        ],
      ),
    );
  }

  _Bodytext(String text) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0, top: 9.0, left: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(text,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black))
            ],
          ),
        ),
      ],
    );
  }
}
