import 'package:flutter/material.dart';
import 'ItemCardAll.dart';
import '../Data(needed)/DatacategoryAll.dart';
import 'package:foodflash/src/models/ModelCategoryAll.dart';

class ItemCatAll extends StatelessWidget {
  final List<Availcategoryall> _categoriesall = availableall;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _categoriesall.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCardAll(
            ItemName: _categoriesall[index].ItemName,
            ImagePath: _categoriesall[index].ImagePath,
            ItemPrice: _categoriesall[index].ItemPrice,
            ItemDescription: _categoriesall[index].ItemDescription,
          );
        },
      ),
    );
  }
}
