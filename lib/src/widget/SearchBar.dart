import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "What would you like to eat ?",
          suffixIcon: Material(
            elevation: 2.0,
            borderRadius: BorderRadius.circular(30.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
        ),
      ),
    );
  }
}
