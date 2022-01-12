// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../pages/ItemInfo.dart';

class ItemCardAll extends StatelessWidget {
  final String ItemName;
  final String ImagePath;
  final double ItemPrice;
  final String ItemDescription;

  ItemCardAll(
      {required this.ItemName,
      required this.ImagePath,
      required this.ItemPrice,
      required this.ItemDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenFood(
                      initialValue: this.ItemName,
                      initialValue1: this.ImagePath,
                      initialValue2: this.ItemPrice,
                      initialValue3: this.ItemDescription)),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          ItemName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromRGBO(255, 145, 77, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ItemDescription,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 9.5,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(71, 240, 71, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 9.5),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(71, 240, 71, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              ItemPrice.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 9.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Ratings",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 7,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.orangeAccent,
                          ),
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.orangeAccent,
                          ),
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.orangeAccent,
                          ),
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight,
                      image: AssetImage(ImagePath),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
