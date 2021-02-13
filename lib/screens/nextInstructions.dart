import 'package:detectas/screens/menuScreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'cameraScreen.dart';

class NextStepsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final circle = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          // backgroundImage: AssetImage('assets/circle.jpg'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Done!',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Next steps are taking an image for ...",
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final buttonRow = (Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(CameraScreen());
            },
            child: Text('Take photo'),
          ),
        ],
      ),
    ));

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[circle, welcome, description, buttonRow],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
