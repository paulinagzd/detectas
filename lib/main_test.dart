//https://maps.googleapis.com/maps/api/place/autocomplete/json?return=formatted_address&input=autism&radius=4000&location=45.521563,%20-122.677433&key=AIzaSyBxq978quqbPfNx-D8qv-a92KPpByANzFc=

// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:location/location.dart';

import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';

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

    var addresses = [];

    String query1 = jsonResponse['predictions'][0]['secondary_text'];
    var addr1 = await Geocoder.local.findAddressesFromQuery(query1);
    addresses.add(addr1.first);

    // String query2 = jsonResponse['predictions'][1]['secondary_text'];
    // var addr2 = await Geocoder.local.findAddressesFromQuery(query2);
    // addresses.add(addr2.first);

    // String query3 = jsonResponse['predictions'][2]['secondary_text'];
    // var addr3 = await Geocoder.local.findAddressesFromQuery(query3);
    // addresses.add(addr3.first);

    // String query4 = jsonResponse['predictions'][3]['secondary_text'];
    // var addr4 = await Geocoder.local.findAddressesFromQuery(query4);
    // addresses.add(addr4.first);

    // String query5 = jsonResponse['predictions'][4]['secondary_text'];
    // var addr5 = await Geocoder.local.findAddressesFromQuery(query5);
    // addresses.add(addr5.first);

    setState(() {
      _markers.clear();
      var ctr = 0;
      // for (final office in jsonResponse['predictions']) {
      for (var i = 0; i < 1; i++) {
        // -----Below code added to try geolocation, trouble b/c of await inside asynchronous func

        var office = jsonResponse['predictions'][i];
        final marker = Marker(
          markerId: MarkerId(office['placeID'].toString()),
          // position: LatLng(45.521563, -122.677433),
          // Below address for geocoder
          position: LatLng(addresses[ctr].coordinates.latitude,
              addresses[ctr].coordinates.longitude),
          infoWindow: InfoWindow(
            title: office['description'],
            snippet: office['secondary_text'],
          ),
        );
        _markers[office['description']] = marker;
        ctr += 1;
      }
    });
  }

  var location = Location();
  Map<String, double> userLocation;

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
            target: LatLng(45.521563, -122.677433),
            zoom: 10,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
