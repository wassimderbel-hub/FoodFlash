import 'package:flutter/material.dart';
import 'ItemCard.dart';
import '../Data(needed)/Datacategory.dart';
import '../models/Modelcategory.dart';

class ItemCat extends StatelessWidget {
  final List<availcategory> _categories = available;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCard(
            categoryName: _categories[index].categoryName,
            imagePath: _categories[index].imagePath,
            price: _categories[index].price,
            pathviewAll: _categories[index].pathviewAll,
            description: _categories[index].description,
            noOfItem: 1,
          );
        },
      ),
    );
  }
}
