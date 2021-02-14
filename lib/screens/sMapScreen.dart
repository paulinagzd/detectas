import 'dart:async';

import 'package:detectas/screens/menuScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import '../src/blocs/appBloc.dart';
import '../src/models/place.dart';
import 'package:provider/provider.dart';
import 'package:after_init/after_init.dart';
import 'menuScreen.dart';

class SpecialistsMap extends StatefulWidget {
  SpecialistsMap({Key key}) : super(key: key);

  @override
  _SpecialistsMapState createState() => _SpecialistsMapState();
}

class _SpecialistsMapState extends State<SpecialistsMap>
    with AfterInitMixin<SpecialistsMap> {
  Completer<GoogleMapController> _mapController = Completer();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didInitState() {
    // No need to call super.didInitState().
    // setState() is not required because build() will automatically be called by Flutter.
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    setIcons(applicationBloc, context);

    //Listen for selected Location
    applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
  }

  setIcons(ApplicationBloc applicationBloc, BuildContext context) async {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
    var locationIcon = await BitmapDescriptor.fromAssetImage(
        configuration, 'assets/location.png');
    applicationBloc.setLocationIcon(locationIcon);
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_outlined),
              tooltip: 'Next page',
              onPressed: () {
                // TODO: Go back to main scren
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
                // Navigator.popUntil(context, (route) => false);
              },
            ),
          ],
          title: Text('Resources'),
        ),
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Search by City',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => applicationBloc.searchPlaces(value),
                      onTap: () => applicationBloc.clearSelectedLocation(),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 300.0,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBloc.currentLocation.latitude,
                                applicationBloc.currentLocation.longitude),
                            zoom: 14,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          markers: Set<Marker>.of(applicationBloc.markers),
                        ),
                      ),
                      if (applicationBloc.searchResults != null &&
                          applicationBloc.searchResults.length != 0)
                        Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                backgroundBlendMode: BlendMode.darken)),
                      if (applicationBloc.searchResults != null)
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc
                                        .searchResults[index].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    applicationBloc.setSelectedLocation(
                                        applicationBloc
                                            .searchResults[index].placeId);
                                  },
                                );
                              }),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Find Nearest',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: [
                        FilterChip(
                          label: Text('Pediatricians'),
                          onSelected: (val) => applicationBloc.togglePlaceType(
                              'developmental+pediatrician', val, true),
                          selected: applicationBloc.placeType ==
                              'developmental+pediatrician',
                          selectedColor: Colors.blue,
                        ),
                        FilterChip(
                            label: Text('Psychiatrists'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('psychiatrist', val, true),
                            selected:
                                applicationBloc.placeType == 'psychiatrist',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('Special Ed'),
                            onSelected: (val) =>
                                applicationBloc.togglePlaceType(
                                    'special+education+school', val, true),
                            selected: applicationBloc.placeType ==
                                'special+education+school',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('Physiotherapy'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('physiotherapist', val, false),
                            selected:
                                applicationBloc.placeType == 'physiotherapist',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('Speech Therapy'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('speech+therapist', val, true),
                            selected:
                                applicationBloc.placeType == 'speech+therapist',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('Audiologists'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('audiologist', val, true),
                            selected:
                                applicationBloc.placeType == 'audiologist',
                            selectedColor: Colors.blue),
                      ],
                    ),
                  )
                ],
              ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}
