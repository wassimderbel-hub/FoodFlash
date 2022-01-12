// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:foodflash/src/screens/adminScreen.dart';

import '../../../screens/PrincipalScreen.dart';
import '../../Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isloading = false;

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(255, 145, 77, 1)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Welcome to FoodFlash",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 10),
            _logintext('Email'),
            _formemail(),
            _logintext('Password'),
            _formpass(),
            Text("\n"),
            Container(
                height: 36,
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 145, 77, 1)),
                    onPressed: () async {
                      if ((email.trim().isEmpty) && (password.trim().isEmpty)) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Color.fromARGB(100, 71, 240, 71),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('All Fields are Empty !',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            )));
                      }
                      if (email.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Color.fromARGB(100, 71, 240, 71),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Please Enter Your Email !',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            )));
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Color.fromARGB(100, 71, 240, 71),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Please Enter a valid Email !',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            )));
                      } else if (password.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Color.fromARGB(100, 71, 240, 71),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Please Enter Your Passowrd !',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            )));
                      } else {
                        return await loginUser();
                      }
                    },
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2,
                            color: Colors.white)))),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Text(
                  " Or ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            _socialLogin(),
            SizedBox(height: 5),
            _signupRedirect(context),
          ],
        ),
      ),
    ));
  }

  _signupRedirect(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Text(
            "Don't have an account?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SignUpScreen()));
            },
            child: Text(
              " Create one",
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

  _socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: Image.asset(
            "../../../assets/images/facebook.png",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 50),
        InkWell(
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(
              "../../../assets/images/google.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  _formpass() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                hintText: 'Password',
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

  _formemail() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            // ignore: missing_return
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter Email";
              }
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Email',
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

  _logintext(String text) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
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

  Future loginUser() async {
    try {
      // ignore: unused_local_variable
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      setState(() {
        if (email == 'admin@gmail.com') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminScreen()));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrincipalScreen()),
          );
        }
      });
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            backgroundColor: Color.fromARGB(100, 71, 240, 71),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No User Found !',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            backgroundColor: Color.fromARGB(100, 71, 240, 71),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wrong Password !',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ],
            )));
      }
    }
  }
}
