import 'package:flutter/material.dart';
import 'quizProcess.dart';

class IntroQuizRoute extends StatelessWidget {
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
        'Welcome to DetectAS!',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "The first step is answering a set of question's based on the child's behavior.",
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage()),
              );
            },
            child: Text('Take quiz!'),
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: const Color(0xFF0099a9),
//       ),
//       body: new Padding(
//         padding: new EdgeInsets.all(30.0),
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Go back!'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => QuizPage()),
//                     );
//                   },
//                   child: Text('Take quiz!'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
