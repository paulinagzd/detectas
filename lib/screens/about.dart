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
        "Is my child autistic? Approximately 25% of children who have autism go undiagnosed (Preidt, D, 2020). In an age where technology should innovate accessible healthcare, DetectAS is the first step before risking a large medical bill. The questionnaire part consists on the Modified Checklist for Autism in Toddlers (M-CHAT™; Robins, Fein, & Barton, 1999), which is largely used by specialists. The facial recognition part uses Convolutional Neural Networks trained to identify possible autistic traits on children from 2 to 8 years old, such as lack of eye contact or emotion. As a disclaimer, we’re not qualified to diagnose a child, but DetectAS applies technology and valuable research in providing an assessment and resources",
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
