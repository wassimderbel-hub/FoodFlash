import 'package:cloud_firestore/cloud_firestore.dart';
import 'createuserscreen.dart';
import 'edituserdata.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController emailController = new TextEditingController();

  String email = " ";
  String uid = " ";
  String username = " ";
  String address = " ";
  String function = " ";
  String phonenumber = " ";
  String cart1 = '';
  String cart3 = '';
  String cart2 = '';
  String feed1 = '';
  List<List> data = [];
  List<String> feed = [];

  bool ableToEdit = false;

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Welcome Admin", style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                cursorColor: Color.fromRGBO(255, 145, 77, 1),
                controller: emailController,
                decoration: InputDecoration(
                  focusColor: Color.fromRGBO(255, 145, 77, 1),
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  String userEmail = emailController.text.trim();

                  final QuerySnapshot snap = await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: userEmail)
                      .get();
                  setState(() {
                    email = userEmail;
                    uid = snap.docs[0].id;
                    username = snap.docs[0]['username'];
                    address = snap.docs[0]['Address'];
                    phonenumber = snap.docs[0]['phoneNumber'];
                    function = snap.docs[0]['function'];

                    ableToEdit = true;
                  });
                  final QuerySnapshot snap2 = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('cart')
                      .get();
                  setState(() {
                    for (var i = 0; i < snap2.size; i++) {
                      data.insert(i, [
                        snap2.docs[i]['ItemName'],
                        snap2.docs[i]['Quantity']
                      ]);
                    }
                    print(data);
                    cart1 = data[0][0];
                    cart2 = data[1][0];

                    ableToEdit = true;
                  });
                  final QuerySnapshot snap3 = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .collection('Feedback')
                      .get();
                  setState(() {
                    for (var i = 0; i < snap3.size; i++) {
                      feed.insert(i, snap3.docs[i]['Message']);
                    }
                    feed1 = feed[0];

                    ableToEdit = true;
                  });
                },
                child: Container(
                  height: 50,
                  width: 100,
                  color: Color.fromRGBO(255, 145, 77, 1),
                  child: Center(
                    child: Text(
                      "Get User Data",
                    ),
                  ),
                ),
              ),
              ableToEdit
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditUser(
                                      uid: uid,
                                      key: null,
                                    )));
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        color: Color.fromRGBO(255, 145, 77, 1),
                        child: Center(
                          child: Text(
                            "Edit User",
                          ),
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateUser()));
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
              SizedBox(
                height: 30,
              ),
              Text(
                'User Data :',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Email : ' + email,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'UID : ' + uid,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Username : ' + username,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Function : ' + function,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'PhoneNumber : ' + phonenumber,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Address : ' + address,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Text('User Data :', style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Text(
                'cart:' + cart1 + '' + cart2,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'Feedback: ' + feed1,
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ));
  }
}
