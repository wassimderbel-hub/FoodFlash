import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUser extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CreateUser> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();

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
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Create User",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextFormField(
            cursorColor: Color.fromRGBO(255, 145, 77, 1),
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              focusColor: Color.fromRGBO(255, 145, 77, 1),
            ),
          ),
          TextFormField(
            cursorColor: Color.fromRGBO(255, 145, 77, 1),
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              focusColor: Color.fromRGBO(255, 145, 77, 1),
            ),
          ),
          TextFormField(
            cursorColor: Color.fromRGBO(255, 145, 77, 1),
            controller: roleController,
            decoration: InputDecoration(
              hintText: "Username",
              focusColor: Color.fromRGBO(255, 145, 77, 1),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              String email = emailController.text.trim();
              String password = passwordController.text.trim();
              String username = roleController.text.trim();
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                    .set(
                        {'username': username, 'email': email, 'discounts': 0});
              });
            },
            child: Container(
              height: 50,
              width: 100,
              color: Color.fromRGBO(255, 145, 77, 1),
              child: Center(
                child: Text(
                  "Create User",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
