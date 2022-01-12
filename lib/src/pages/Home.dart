// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodflash/src/Data(needed)/mapfood.dart';
import 'package:foodflash/src/pages/ItemInfo.dart';
import 'package:foodflash/src/screens/PrincipalScreen.dart';
import 'package:foodflash/src/widget/ItemCardAll.dart';
import '../widget/FoodRec.dart';
import '../widget/ItemCat.dart';
import '../widget/HomeTop.dart';
//import 'package:animated_background/animated_background.dart';

import '../Data(needed)/Datafood.dart';
import '../models/Modelfood.dart';
import 'Viewall.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> with TickerProviderStateMixin {
  final List<Dataf> _foods = food;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //AnimatedBackground(
          //behaviour: RacingLinesBehaviour(
          // direction: LineDirection.Rtl,
          //  numLines: 5,
          //  ),
          // vsync: this,
          // child:
          ListView(
        padding: EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
        children: <Widget>[
          HomeTop(),
          ItemCat(),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Most Recommended Food",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              GestureDetector(
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color.fromRGBO(255, 145, 77, 1)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewAll()));
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              onTap: () {
                showSearch(context: context, delegate: DataSearch());
              },
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
          ),
          SizedBox(
            height: 15.0,
          ),
          Column(
            children: _foods.map(buildFoodBought).toList(),
          )
        ],
      ),
      //)
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final food = [
    "Tiramisu",
    "Croissant",
    "Pizza",
    "Salad",
    "Chicken",
    "Burger",
    "Brownie",
    "Pasta",
    "Meat brochette",
  ];

  List<Map<String, Object>> all = mfood;

  final recentfood = ["Pizza", "Salad", "Chicken", "Brownie"];
  @override
  Widget buildLeading(BuildContext context) {
    return (Text(''));
  }

  @override
  Widget buildResults(BuildContext context) {
    return (Container(
        height: 280,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              List items = [];
              //print(suggestionList);

              List<String> positions = [
                'ItemName',
                'ImagePath',
                'ItemPrice',
                'ItemDescription'
              ];

              ///print(a);
              for (Map x in all) {
                if (x['ItemName'].toString().toLowerCase() == query) {
                  for (var i = 0; i < x.length; i++) {
                    items.insert(i, x[positions[i]]);
                    print(items);
                  }
                }
              }
              if (items.isEmpty) {
                return Text('This product is unavailable');
              } else {
                return ItemCardAll(
                    ItemName: items[0],
                    ImagePath: items[1],
                    ItemPrice: items[2],
                    ItemDescription: items[3]);
              }
            })));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrincipalScreen()),
          );
        },
      )
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentfood
        : food.where((p) => p.toLowerCase().startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: GestureDetector(
          onTap: () {
            List items = [];
            //print(suggestionList);
            String a = suggestionList[index];
            List<String> positions = [
              'ItemName',
              'ImagePath',
              'ItemPrice',
              'ItemDescription'
            ];

            ///print(a);
            for (Map x in all) {
              //print(x);
              //print(x);
              if (x['ItemName'] == a) {
                //print(x['ItemName']);
                for (var i = 0; i < x.length; i++) {
                  items.insert(i, x[positions[i]]);
                  print(items);
                }
              }
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenFood(
                      initialValue: items[0],
                      initialValue1: items[1],
                      initialValue2: items[2],
                      initialValue3: items[3]),
                ));
          },
          child: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.black, fontSize: 20))
              ],
            ),
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

Widget buildFoodBought(Dataf food) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: ItemRec(
      imagePath: food.imagePath,
      id: food.id,
      name: food.name,
      price: food.price,
      discount: food.discount,
      rate: food.rate,
      category: food.category,
      Description: food.Description,
      pathViewAll: food.pathViewAll,
    ),
  );
}
