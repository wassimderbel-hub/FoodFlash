import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodflash/src/widget/orderCard.dart';

class ReachUs extends StatefulWidget {
  @override
  _ReachUsState createState() => _ReachUsState();
}

class _ReachUsState extends State<ReachUs> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String name = '';
  String message = '';
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reach Us"),
        backgroundColor: Color.fromRGBO(255, 145, 77, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
              child: Text(
                "Leave us a message, and we'll get in contact with you as soon as possible. ",
                style: TextStyle(
                  fontSize: 17.5,
                  height: 1.3,
                  fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  // ignore: unnecessary_null_comparison
                  if (val != null || val.length > 0) name = val;
                },
                controller: t1,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Your name',
                  hintStyle: TextStyle(
                      color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0001,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  // ignore: unnecessary_null_comparison
                  if (val != null || val.length > 0) message = val;
                },
                textAlign: TextAlign.start,
                controller: t2,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  hintText: 'Your message',
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'RobotoSlab',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(17),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              color: Color.fromRGBO(255, 145, 77, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      backgroundColor: Color.fromARGB(100, 71, 240, 71),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Feedback sent successfully !',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      )));
                  setState(() {
                    final CollectionReference users =
                        FirebaseFirestore.instance.collection('users');
                    FirebaseFirestore.instance
                        .runTransaction((Transaction transaction) async {
                      // ignore: unused_local_variable
                      CollectionReference reference =
                          FirebaseFirestore.instance.collection('users');
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('Feedback')
                          .doc('userFeedback')
                          .set({
                        'Name': name,
                        'Message': message,
                      });
                    });
                  });
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                        "Send",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'RobotoSlab'),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 21,
                  right: 21,
                  bottom: MediaQuery.of(context).size.height * 0.034),
              child: Text(
                "Alternatively, you can also report bugs and errors on following platforms",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.blueGrey[600],
                  fontSize: 17,
                  height: 1.3,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    FontAwesomeIcons.github,
                    color: Color.fromRGBO(71, 240, 120, 1),
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.googlePlay,
                      color: Color.fromRGBO(71, 240, 120, 1), size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  child: Icon(FontAwesomeIcons.at,
                      color: Color.fromRGBO(71, 240, 120, 1), size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
