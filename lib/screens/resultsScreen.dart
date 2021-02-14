import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../src/blocs/appBloc.dart';
import 'package:provider/provider.dart';

import 'sMapScreen.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SpecialistsMap(),
      ),
    );
  }
}
