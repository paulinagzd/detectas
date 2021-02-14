import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'models/ml_response.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  List<File> _images = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  bool isLoading = false;
  int predictedClass = -1;
  String description = "";
  bool done = false;

  Future _getImageFromMemory(BuildContext buildContext) async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        // _images.add(File(pickedFile.path));
        getImageResponseFromMLServer(buildContext, File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getImageFromCamera() async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
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

    var response = await request.send();
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Pick Image"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Floating Action Btn',
        child: const Icon(Icons.refresh),
      ),
      body: Builder(
        builder: (buildContext) => Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          child: ListView(
            children: <Widget>[
              (done
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(FontAwesomeIcons.camera), onPressed: _getImageFromCamera),
                        IconButton(icon: Icon(Icons.attach_file), onPressed: () {_getImageFromMemory(buildContext);}),
                      ],
                    )
              ),
              predictedClass == -1 ? Container() : Text(predictedClass.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
