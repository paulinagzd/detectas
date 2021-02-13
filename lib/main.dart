//https://maps.googleapis.com/maps/api/place/autocomplete/json?return=formatted_address&input=autism&radius=4000&location=45.521563,%20-122.677433&key=AIzaSyBxq978quqbPfNx-D8qv-a92KPpByANzFc=

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    var googleOffices = await rootBundle.loadString('assets/places.json');
    Map jsonResponse = json.decode(googleOffices);

    setState(() {
      _markers.clear();
      for (final office in jsonResponse['predictions']) {
        final marker = Marker(
          markerId: MarkerId(office['placeID'].toString()),
          position: LatLng(45.521563, -122.677433),
          infoWindow: InfoWindow(
            title: office['description'],
            snippet: office['secondary_text'],
          ),
        );
        _markers[office['description']] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Office Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(45.521563, -122.677433),
            zoom: 10,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
