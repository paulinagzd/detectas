import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/questions.dart';
import 'nextInstructions.dart';
import '../components/body.dart';

class QuizPage extends StatelessWidget {
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: Body(),
    );
  }
}
// Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: const Color(0xFF0099a9),
//       ),
//       body: new Padding(
//           padding: new EdgeInsets.all(30.0),
//           child: Column(children: <Widget>[
//             Row(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       Constants.Question1.text,
//                       maxLines: 7,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => NextStepsPage()),
//                         );
//                       },
//                       child: Text('Take quiz!'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => NextStepsPage()),
//                     );
//                   },
//                   child: Text('True'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Go back!'),
//                 ),
//               ],
//             )
//           ])));
