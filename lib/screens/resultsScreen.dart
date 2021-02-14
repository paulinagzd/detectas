import 'package:detectas/utilities/get_autism_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../src/blocs/appBloc.dart';
import 'package:provider/provider.dart';

import 'sMapScreen.dart';

class Results extends StatelessWidget {
  List<int> selectedAnswersList;
  int predictedClass;

  Results(this.selectedAnswersList, this.predictedClass);

  @override
  Widget build(BuildContext context) {
//    return ChangeNotifierProvider(
//      create: (context) => ApplicationBloc(),
//      child: MaterialApp(
//        title: 'Flutter Demo',
//        home: SpecialistsMap(),
//      ),
//    );

    double probability = 0.0;
    bool showRecommendations = haveAutisticSigns(selectedAnswersList, predictedClass);

    final circle = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          alignment: Alignment.center,
          child: new Image.asset('assets/images/after.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Results',
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        showRecommendations ? "Candidate show some signs of autism. You should go see a specialist" : "Candidate does not show any signs of autism.",
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
                    MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider(
                        create: (context) => ApplicationBloc(),
                        child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'Recommendations',
                          home: SpecialistsMap(),
                        ),
                      );
                    }),
                  );
                },
                child: Text('Recommendations', style: TextStyle(fontSize: 28.0)),
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
        children: <Widget>[circle, welcome, description, showRecommendations ? buttonRow : Container()],
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
