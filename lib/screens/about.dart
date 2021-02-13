import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: new Padding(
            padding: new EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'about',
                          maxLines: 7,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Go back!'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}
