import 'package:flutter/material.dart';
import 'cameraScreen.dart';

class NextStepsPage extends StatelessWidget {
  List<int> selectedAnswersList;

  NextStepsPage(this.selectedAnswersList);

  @override
  Widget build(BuildContext context) {
    final circle = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: new Image.asset('assets/images/selfie.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Next steps',
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        "Now that the quiz has been answered, a picture of the candidate's face is required to continue. It will identify possible autistic traits on children from 2 to 8 years old.",
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
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 70.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Colors.blue, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen(selectedAnswersList)),
                  );
                },
                child: Text('Take photo', style: TextStyle(fontSize: 28.0)),
              ),
            )
          ],
        ),
      ),
    ));

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(0.0),
      child: ListView(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0), child: circle),
          Padding(padding: const EdgeInsets.all(8.0), child: welcome),
          Padding(padding: const EdgeInsets.all(8.0), child: description),
          Container(padding: const EdgeInsets.all(8.0), child: buttonRow),
        ],
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            // Flutter show the back button automatically
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: body,
          ))
    ]);
  }
}
