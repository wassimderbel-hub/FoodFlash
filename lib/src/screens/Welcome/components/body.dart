import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class Body extends StatefulWidget {
  @override
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 150,
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(255, 145, 77, 1)),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _placeholder(),
            Container(
                height: 46,
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 145, 77, 1)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    },
                    child: Text("Login",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                          color: Colors.white,
                        )))),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 46,
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SignUpScreen()));
                    },
                    child: Text("SignUp",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                          color: Color.fromRGBO(255, 145, 77, 1),
                        )))),
          ],
        ),
      ),
    );
  }

  _placeholder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: Image.asset("../../../assets/images/FoodFlash.png"),
        )
      ],
    );
  }
}
