import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_circle_distance/great_circle_distance.dart';
import 'package:rider/pages/about_page.dart';
import 'package:rider/services/emergency_call.dart';
import 'package:rider/services/map.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/map_style.dart';
import 'package:rider/utils/ui_helpers.dart';
import 'package:rider/utils/variables.dart';
import 'package:rider/widgets/swipe_button.dart';

class MyMapViewPage extends StatefulWidget {
  @override
  _MyMapViewPageState createState() => _MyMapViewPageState();
}

class _MyMapViewPageState extends State<MyMapViewPage> {
  void initState() {
    super.initState();
    _setCurrentLocation();
  } // gets current user location when the app loads

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    if (isFirstLaunch) {
      _populateMarkers();
      mapController
          .setMapStyle(isThemeCurrentlyDark(context) ? aubergine : retro);
      isFirstLaunch = false;
    } else {
      mapController
          .setMapStyle(isThemeCurrentlyDark(context) ? retro : aubergine);
    }

    new Timer.periodic(interval, (Timer t) {
      _populateMarkers(); // updates markers every 10 seconds
    });
  }

  void _setCurrentLocation() {
    Geolocator().getCurrentPosition().then((currLoc) {
      setState(() {
        currentLocation = currLoc;
      });
    });
  }

  static final currentLocation1 = getCurrentLocation();

  var gcd = new GreatCircleDistance.fromDegrees(
      latitude1: currentLocation1.latitude,
      longitude1: currentLocation1.longitude,
      latitude2: 19.1077678,
      longitude2: 72.8362055);

  Color colorMarker;
  double radius = 75.0;

  void _markCurrentLocation() {
    var currentLocation = getCurrentLocation();
    var markerIdVal = Random().toString();
    final MarkerId markerId = MarkerId(markerIdVal);
    var marker = Marker(
      markerId: markerId,
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(147.5),
      infoWindow: InfoWindow(title: 'My Marker', snippet: 'Current location'),
      onTap: doNothing,
    );

    setState(() {
      markers[markerId] = marker;
    });
  } //adds current location as a marker to map and writes to db

  void _getMarkersFromDb(clients) {
    if (radius >= gcd.haversineDistance()) {
      colorMarker = Colors.green;
    } else {
      colorMarker = Colors.red;
    }
    for (int i = 0; i < clients.length; i++) {
      final documentId = clients[i].documentID;
      final markerId = MarkerId(documentId);
      final markerData = clients[i].data;
      final markerPosition = LatLng(markerData['position']['geopoint'].latitude,
          markerData['position']['geopoint'].longitude);

      var marker = Marker(
          markerId: markerId,
          position: markerPosition,
          icon: colorMarker == Colors.green
              ? BitmapDescriptor.defaultMarkerWithHue(130.0)
              : BitmapDescriptor.defaultMarker,
          infoWindow:
              InfoWindow(title: 'ID: $markerId', snippet: 'Data: $markerData'),
          onTap: () {
            _deleteMarker(documentId);
          });

      setState(() {
        markers[markerId] = marker;
        hotspots.add(Circle(
          circleId: CircleId(markerId.toString()),
          center: markerPosition,
          radius: 75,
          fillColor: MyColors.translucentColor,
          strokeColor: MyColors.primaryColor,
          strokeWidth: 8,
          visible: true,
        ));
      });
    }
  }

  void _populateMarkers() {
    Firestore.instance.collection('locations').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        var docLength = docs.documents.length;
        var clients = new List(docLength);
        for (int i = 0; i < docLength; i++) {
          clients[i] = docs.documents[i];
        }
        print('Reopulated $docLength clients');
        _getMarkersFromDb(clients);
      }
    });
  } // renders markers from firestore on the map

  void _deleteMarker(documentId) {
    print('Deleting marker $documentId...');
    _clearMap();
    Firestore.instance.collection('locations').document(documentId).delete();
  }

  void _clearMap() {
    setState(() {
      print('Clearing items from map...');
      markers.clear();
      hotspots.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Icon toggleLightsIcon = isThemeCurrentlyDark(context)
        ? Icon(Icons.brightness_7)
        : Icon(Icons.brightness_2);
    String toggleLightsText =
        isThemeCurrentlyDark(context) ? 'Light mode' : 'Dark mode';
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: zoom[0],
                bearing: bearing[0],
                tilt: tilt[0],
              ),
              markers: Set<Marker>.of(markers.values),
              circles: hotspots,
            ),
            Positioned(
              top: 40.0,
              left: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fliver Rider',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      fontStyle: FontStyle.italic,
                      color: invertColorsStrong(context),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isSwipeButtonVisible,
              child: Positioned(
                top: 40.0,
                right: 20.0,
                child: FloatingActionButton(
                  mini: true,
                  child: Icon(
                    Icons.warning,
                    size: 20.0,
                  ),
                  tooltip: 'Emergency',
                  foregroundColor: invertInvertColorsTheme(context),
                  backgroundColor: invertColorsTheme(context),
                  elevation: 5.0,
                  onPressed: () {
                    showEmergencyPopup(context);
                  },
                ),
              ),
            ),
            Visibility(
              visible: isSwipeButtonVisible,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SwipeButton(
                  thumb: Icon(Icons.arrow_forward_ios),
                  content: Center(
                    child: Text('Swipe to mark location'),
                  ),
                  onChanged: (result) {
                    if (result == SwipePosition.SwipeRight) {
                      setState(() {
                        isSwipeButtonVisible = false;
                        isFabVisible = true;
                      });
                      locationAnimation = 1;
                      animateToCurrentLocation(locationAnimation);
                      _markCurrentLocation();
                      writeToDb();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: SpeedDial(
          heroTag: 'fab',
          closeManually: false,
          foregroundColor: invertInvertColorsTheme(context),
          backgroundColor: invertColorsTheme(context),
          animatedIcon: AnimatedIcons.menu_close,
          elevation: 5.0,
          children: [
            SpeedDialChild(
              child: Icon(Icons.my_location),
              foregroundColor: invertColorsTheme(context),
              backgroundColor: invertInvertColorsTheme(context),
              label: 'Recenter',
              labelStyle: TextStyle(
                  color: MyColors.accentColor, fontWeight: FontWeight.w500),
              onTap: () {
                if (locationAnimation == 0) {
                  locationAnimation = 1;
                } else if (locationAnimation == 1) {
                  locationAnimation = 0;
                }
                animateToCurrentLocation(locationAnimation);
              },
            ),
            SpeedDialChild(
              child: toggleLightsIcon,
              foregroundColor: invertColorsTheme(context),
              backgroundColor: invertInvertColorsTheme(context),
              label: toggleLightsText,
              labelStyle: TextStyle(
                  color: MyColors.accentColor, fontWeight: FontWeight.w500),
              onTap: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark);
                _onMapCreated(mapController); //buggy
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.info_outline),
              foregroundColor: invertColorsTheme(context),
              backgroundColor: invertInvertColorsTheme(context),
              label: 'About',
              labelStyle: TextStyle(
                  color: MyColors.accentColor, fontWeight: FontWeight.w500),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return MyAboutPage();
                }));
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.bug_report),
              foregroundColor: invertColorsTheme(context),
              backgroundColor: invertInvertColorsTheme(context),
              label: 'Debug',
              labelStyle: TextStyle(
                  color: MyColors.accentColor, fontWeight: FontWeight.w500),
              onTap: () {
                _clearMap();
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.warning),
              foregroundColor: MyColors.white,
              backgroundColor: MaterialColors.red,
              label: 'Emergency',
              labelStyle: TextStyle(
                  color: MyColors.accentColor, fontWeight: FontWeight.w500),
              onTap: () {
                showEmergencyPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
