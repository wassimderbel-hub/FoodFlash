import 'package:flutter/material.dart';
import 'package:foodflash/src/pages/ItemInfo.dart';

class ItemCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int noOfItem;
  final double price;
  final String description;
  final String pathviewAll;

  ItemCard(
      {required this.categoryName,
      required this.imagePath,
      required this.noOfItem,
      required this.price,
      required this.description,
      required this.pathviewAll});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScreenFood(
                    initialValue: this.categoryName,
                    initialValue1: this.pathviewAll,
                    initialValue2: this.price,
                    initialValue3: this.description)),
          );
        },
        child: Card(
          color: Color.fromRGBO(255, 145, 77, 0.4),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage(imagePath),
                  height: 100.0,
                  width: 100.0,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      categoryName,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
