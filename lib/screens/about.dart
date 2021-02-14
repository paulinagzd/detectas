import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'About the App',
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        "This app helps detect signs of autism in children.",
        style: TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    final developers = Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        "By Chirag Mohapatra, Lauren Niemec, Paulina González, and Vishal Singh for TreeHacks 2021",
        style: TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[welcome, description, developers],
      ),
    );

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Center(
              child: body,
            ))
      ],
    );
  }
}
