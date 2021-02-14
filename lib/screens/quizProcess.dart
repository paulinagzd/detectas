import 'package:flutter/material.dart';
import '../components/body.dart';

class QuizPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        extendBodyBehindAppBar: true,
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
         ),
        body: Body(),
      )
    ]);
  }
}
