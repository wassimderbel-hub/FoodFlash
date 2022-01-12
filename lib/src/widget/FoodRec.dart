// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:foodflash/src/pages/ItemInfo.dart';

class ItemRec extends StatefulWidget {
  final String id;
  final String name;
  final String category;
  final String imagePath;
  final double price;
  final double discount;
  final double rate;
  final String pathViewAll;
  final String Description;

  @override
  _BoughtFoodState createState() => _BoughtFoodState();
  ItemRec(
      {required this.id,
      required this.name,
      required this.category,
      required this.imagePath,
      required this.discount,
      required this.Description,
      required this.pathViewAll,
      required this.price,
      required this.rate,
      double? stars});
}

class _BoughtFoodState extends State<ItemRec> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScreenFood(
                        initialValue: widget.name,
                        initialValue1: widget.pathViewAll,
                        initialValue2: widget.price,
                        initialValue3: widget.Description)),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 340.0,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    child: Container(
                      height: 60.0,
                      width: 340.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black54,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    right: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(71, 240, 120, 1),
                                  size: 16.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(71, 240, 120, 1),
                                  size: 16.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(71, 240, 120, 1),
                                  size: 16.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(71, 240, 120, 1),
                                  size: 16.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(71, 240, 120, 1),
                                  size: 16.0,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  "(${widget.rate} Review )",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "${widget.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellowAccent,
                                  fontSize: 18.0),
                            ),
                            Text(
                              "Price (TND)",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
