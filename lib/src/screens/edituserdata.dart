import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final String uid;

  EditUser({Key? key, required this.uid}) : super(key: key);
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController roleController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Edit User",
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
            controller: roleController,
            decoration: InputDecoration(
              hintText: "Usename...",
              focusColor: Color.fromRGBO(255, 145, 77, 1),
            ),
          ),
          TextFormField(
            cursorColor: Color.fromRGBO(255, 145, 77, 1),
            controller: mailController,
            decoration: InputDecoration(
              hintText: "Mail...",
              focusColor: Color.fromRGBO(255, 145, 77, 1),
              hoverColor: Color.fromRGBO(255, 145, 77, 1),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              String newusername = roleController.text.trim();
              String newmail = mailController.text.trim();

              final CollectionReference users =
                  FirebaseFirestore.instance.collection('users');
              FirebaseFirestore.instance
                  .runTransaction((Transaction transaction) async {
                // ignore: unused_local_variable
                CollectionReference reference =
                    FirebaseFirestore.instance.collection('users');

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                    .update({'username': newusername, 'email2': newmail});
              });
            },
            child: Container(
              height: 50,
              width: 100,
              color: Color.fromRGBO(255, 145, 77, 1),
              child: Center(
                child: Text(
                  "UPDATE DATA",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
