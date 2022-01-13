import 'package:flutter/material.dart';
import 'package:foodflash/src/screens/Welcome/welcome_screen.dart';
import 'package:foodflash/src/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
//here we initialize our app on firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDd6BgKR0bANlzNytKm_XSPVUXN9Sgnj3w",
      appId: "1:182170353582:android:0df0c43930dadd1656d23f",
      messagingSenderId:
          "182170353582-7f4r4g6uupd5hvbc724pvlmhums4stjm.apps.googleusercontent.com",
      projectId: "foodflashproject",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FoodFlash",
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: AnimatedSplashScreen(),   //our first page is the splash screen
    );
  }
}
