import 'dart:convert';
import 'dart:io';

import 'package:detectas/models/ml_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';

import 'resultsScreen.dart';

class CameraScreen extends StatefulWidget {
  List<int> selectedAnswersList;

  CameraScreen(this.selectedAnswersList);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<File> _images = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  bool isLoading = false;
  int predictedClass = -1;
  String description = "";
  bool done = false;

  Future _getImageFromMemory(BuildContext buildContext) async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // _images.add(File(pickedFile.path));
        getImageResponseFromMLServer(buildContext, File(pickedFile.path));
      } else {
        print('No image selected.');
      }
  }

  Future _getImageFromCamera(BuildContext buildContext) async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedFile != null) {
        // _images.add(File(pickedFile.path));
        getImageResponseFromMLServer(buildContext, File(pickedFile.path));
      } else {
        print('No image selected.');
      }
  }

  Future<MLResponse> getImageResponseFromMLServer(BuildContext buildContext, File imageFile) async {
    ProgressDialog pr;
    pr = new ProgressDialog(buildContext, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.show();
    await Future.delayed(Duration(seconds: 1));

    var postUri = Uri.https('detectas.azurewebsites.net', 'classify_image');
    var request = new http.MultipartRequest("POST", postUri);
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile("file", stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);

    try {
      var response = await request.send();
      // request.send().then((response) => null).catchError(onError);
      print(response.statusCode);
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          MLResponse mlResponse = MLResponse.fromJson(jsonDecode(value));
          print(jsonDecode(value));
          print(mlResponse.toString());
          setState(() {
            isLoading = false;
            predictedClass = mlResponse.cls;
            if (predictedClass == 0 || predictedClass == 1) {
              done = true;
            }
            description = mlResponse.description;
            if (description != "") {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(description)));
            }
            pr.hide();
          });
        });
      } else {
        setState(() {
          pr.hide();
          isLoading = false;
          description = "Can't get response from server. Check if the file size is not very large and you have a stable internet connection";
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Check Internet Connection")));
        });
      }
    } catch (error) {
      print(error);
      print("I am having an error");
      pr.hide();
      isLoading = false;
      description = "No internet connection";
    }



    //    request.send().then((StreamedResponse response) async {
    //      print(response.toString());
    //      final respStr = await response.stream.bytesToString();
    //      print(respStr);
    //      // if (response.statusCode == 200) print("Uploaded!");
    //      if (response.statusCode == 200) {
    //        // return MLResponse.fromJson(jsonDecode(response.));
    //      } else {
    //        throw Exception('Failed to create album.');
    //      }
    //    });
  }

  @override
  Widget build(BuildContext context) {
    final body = Builder(
      builder: (buildContext) =>
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: ListView(
              children: <Widget>[
                done ? Center(child: Text("Image processed")) : Center(child: Text("Capture an image or choose one from gallery")),
                (done
                    ? Container()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(icon: Icon(FontAwesomeIcons.camera), onPressed: () {
                      _getImageFromCamera(buildContext);
                    }),
                    IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () {
                          _getImageFromMemory(buildContext);
                        }),
                  ],
                )),
//                predictedClass == -1
//                    ? Container()
//                    : Text(
//                  predictedClass.toString(),
//                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Center(child: Text(description)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Text(predictedClass == -1 ? "Predict results without taking image" : "Next", style: TextStyle(fontSize: 16),),
                    textColor: Colors.white,
                    color: Theme
                        .of(context)
                        .accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Results(widget.selectedAnswersList, predictedClass)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );

    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/background.png",
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          key: _scaffoldKey,
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
