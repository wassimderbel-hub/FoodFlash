import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:foodflash/src/pages/checkout.dart';

import '../widget/orderCard.dart';

class Order extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<Order> {
  final db = FirebaseFirestore.instance;
  var total = 0.0;
  num total1 = 0;
  int dscts = 0;
  String quant = '0';

  // ignore: must_call_super

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ordered Items List",
          style: TextStyle(color: Colors.black, fontSize: 23.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('cart')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var ds = snapshot.data!.docs;

              double sum1 = 0.0;
              // ignore: unused_local_variable
              double totalsum = 0.0;

              for (int i = 0; i < ds.length; i++) {
                for (Map x in ds[i]['Quantity']) sum1 += x['Quantity'];
                totalsum += sum1 * ds[i]['ItemPrice'];
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    var ds = snapshot.data!.docs;
                    double sum = 0.0;

                    for (Map x in ds[index]['Quantity']) sum += x['Quantity'];

                    return OrderCard(
                        ItemName: snapshot.data!.docs[index]['ItemName'],
                        ImagePath: snapshot.data!.docs[index]['ImagePath'],
                        ItemPrice: snapshot.data!.docs[index]['ItemPrice'],
                        ItemDescription: snapshot.data!.docs[index]
                            ['ItemDescription'],
                        ItemQuantity: sum);
                  },
                );
              }
            } else {
              return Text("No selected elements in Cart");
            }
          }),
      bottomNavigationBar: orderDetail(),
    );
  }

  Widget orderDetail() {
    return (StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var ds = snapshot.data!.docs;
            double totalsum = 0.0;
            num sum1 = 0;
            int sub1 = 0;
            String sub;
            var charge = 0.0;
            var discount = 0.0;
            for (int i = 0; i < ds.length; i++) {
              for (Map x in ds[i]['Quantity']) sum1 += x['Quantity'];
              total1 += sum1;
              totalsum += sum1 * ds[i]['ItemPrice'];
              sum1 = 0;
            }
            FirebaseFirestore.instance
                .runTransaction((Transaction transaction) async {
              // ignore: unused_local_variable
              var reference = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('totalcart')
                  .doc('total')
                  .get();

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('totalcart')
                  .doc('total')
                  .set({'total': total1});
            });
            charge = totalsum / 10;

            discount = totalsum / 5;
            sub = (totalsum + charge - discount).toStringAsPrecision(4);

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                height: 220.0,
                margin: EdgeInsets.only(top: 25.0, bottom: 16.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Card Total",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("$totalsum DT",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Delivery charge",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$charge DT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Discount",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$discount DT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      height: 40.0,
                      color: Color(0xFFD3D3D3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Sub Total",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$sub DT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(150, 71, 240, 71),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            dscts++;
                            // ignore: unused_local_variable
                            final CollectionReference users =
                                FirebaseFirestore.instance.collection('users');
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction transaction) async {
                              // ignore: unused_local_variable
                              CollectionReference reference = FirebaseFirestore
                                  .instance
                                  .collection('users');

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({'discounts': dscts});
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CheckoutOnePage(total: sub1)));
                          },
                          child: Text(
                            "Procede to CheckOut",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
