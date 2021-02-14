import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/menuScreen.dart';

void main() {
  runApp(MyApp());
}

//
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DetectAS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        accentColor: Colors.grey,
        appBarTheme: AppBarTheme(
          color: Color(0xFFf7f8fb),
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
