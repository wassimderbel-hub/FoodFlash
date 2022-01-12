// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  String username = '';
  var checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(255, 145, 77, 1)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 20),
        Text(
          "Create your Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 30),
        _Bodytext('Full name'),
        _formfullname(),
        _Bodytext('Email'),
        _formemail(),
        _Bodytext('Password'),
        _formpass(),
        SizedBox(height: 18),
        CheckboxListTile(
          title: Text(
              "By signing up you accept the term of service and privacy policy"),
          secondary: Icon(Icons.ac_unit_rounded),
          value: checkedValue,
          activeColor: Color.fromRGBO(255, 145, 77, 1),
          checkColor: Colors.black,
          onChanged: (newValue) {
            setState(() {
              checkedValue = newValue!;
            });
          },
          controlAffinity:
              ListTileControlAffinity.platform, //  <-- leading Checkbox
        ),
        SizedBox(height: 18),
        Container(
            height: 36,
            width: 300,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 145, 77, 1)),
                onPressed: () async {
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromARGB(100, 71, 240, 71),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Sucessfully Register.You Can Login Now'),
                        ),
                        duration: Duration(seconds: 5),
                      ),

                      // Get a reference to the database service
                    );
                    Navigator.of(context).pop();
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Color.fromARGB(100, 71, 240, 71),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ops! ${e.message}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ],
                        )));
                  }
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
                        .set({
                      'username': username,
                      'email': email,
                      'discounts': 0
                    });
                  });
                },
                child: Text("Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      color: Colors.white,
                    )))),
        SizedBox(
          height: 10,
        ),
        _signupRedirect(context),
        SizedBox(
          height: 5,
        ),
      ])),
    ));
  }

  _signupRedirect(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(
            "Already have an account?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
            },
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(255, 145, 77, 1),
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  _formpass() {
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 5),
      child: Column(
        children: [
          TextFormField(
            obscureText: true,
            // ignore: missing_return
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter Password";
              }
            },
            onChanged: (value) {
              password = value;
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: 'Choose a Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                )),
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

  _formfullname() {
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 5),
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              username = value.toString().trim();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your name',
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

  _formemail() {
    return Padding(
      //padding: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.only(top: 2, left: 5),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value.toString().trim();
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
              prefixIcon: Icon(
                Icons.email,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black))
            ],
          ),
        ),
      ],
    );
  }
}
