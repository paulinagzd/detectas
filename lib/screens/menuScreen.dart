import 'package:flutter/material.dart';
import 'introQuiz.dart';
import 'about.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hero = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: new Image.asset('assets/images/detectAS.png'),
          alignment: Alignment.center,
        ),
      ),
    );

    final buttonRow = (Padding(
      padding: EdgeInsets.all(8),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroQuizRoute()),
                  );
                },
                child: Text('Take quiz', style: TextStyle(fontSize: 28.0)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 70.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Theme.of(context).primaryColor, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
                child: Text('About', style: TextStyle(fontSize: 28.0)),
              ),
            )
          ],
        ),
      ),
    ));

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
        ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[hero, buttonRow],
      ),
    );

    return Center(
      child: body,
    );
  }
}
