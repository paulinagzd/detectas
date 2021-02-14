import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'quizProcess.dart';

class IntroQuizRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final circle = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: new Image.asset('assets/images/intro.png'),
          alignment: Alignment.center,
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome to DetectAS!',
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        "The first step is answering the initial M-CHAT™ screening. This helps reduce the false positive rate, keep in mind that this is not a diagnosis.",
        style: TextStyle(fontSize: 16.0, color: Colors.black54),
      ),
    );

    final buttonRow = (Padding(
      padding: EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 70.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Theme.of(context).primaryColor, // foreground
                ),
                onPressed: () {
                  Get.reset();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                child: Text('Start', style: TextStyle(fontSize: 28.0)),
              ),
            )
          ],
        ),
      ),
    ));

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[circle, welcome, description, buttonRow],
      ),
    );

    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Center(
            child: body,
          ))
    ]);
  }
}
