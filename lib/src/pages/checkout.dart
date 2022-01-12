import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutOnePage extends StatelessWidget {
  final int total;

  CheckoutOnePage({required this.total});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 145, 77, 1),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    selectedAddressSection(),
                    checkoutItem(),
                    standardDelivery(),
                    MethodSection()
                  ],
                ),
              ),
              flex: 90,
            ),
          ],
        );
      }),
    );
  }

  selectedAddressSection() {
    return Container(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "James",
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    child: Text(
                      "HOME",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 145, 77, 1), fontSize: 8),
                    ),
                  )
                ],
              ),
              createAddressText(
                  "431, Commerce House, Nagindas Master, Fort", 16),
              createAddressText("Tunisia", 6),
              createAddressText("Ariana", 6),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: "02222673745",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      padding: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {},
            child: Text(
              "Edit / Change",
              style: TextStyle(
                  fontSize: 12, color: Color.fromRGBO(255, 145, 77, 1)),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 3,
          ),
          SizedBox(
            height: 20,
          ),
          Spacer(
            flex: 3,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {},
            child: Text("Add New Address",
                style: TextStyle(
                    fontSize: 12, color: Color.fromRGBO(255, 145, 77, 1))),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  standardDelivery() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Standard Delivery",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Get it by 17 Jan - 25 jan ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  checkoutItem() {
    return Container(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem();
            },
            itemCount: 3,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(
                "images/details_shoes_image.webp",
              ),
              width: 35,
              height: 45,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Estimated Delivery : ",
                  style: TextStyle(fontSize: 12)),
              TextSpan(
                  text: "17 Jan 2022 ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
            ]),
          )
        ],
      ),
    );
  }

  MethodSection() {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          RoundedContainer(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.paypal,
                color: Color.fromRGBO(255, 145, 77, 1),
              ),
              title: Text("Paypal"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.googleWallet,
                color: Color.fromRGBO(255, 145, 77, 1),
              ),
              title: Text("Google Pay"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.applePay,
                color: Color.fromRGBO(255, 145, 77, 1),
              ),
              title: Text("Apple Pay"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: 0,
                padding: const EdgeInsets.all(24.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text("Continue"),
                color: Color.fromRGBO(255, 145, 77, 1),
                textColor: Colors.white,
                onPressed: () {},
              ))
        ]));
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius,
    this.alignment,
    this.elevation,
  }) : super(key: key);
  final Widget child;
  final double? width;
  final double? height;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final AlignmentGeometry? alignment;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      color: color,
      elevation: elevation ?? 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}
