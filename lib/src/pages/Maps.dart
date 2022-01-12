// ignore_for_file: unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: AppConstant.list[index]["title"]));
  });

  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(36.81360345581122, 10.1771), zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
        ),
      ),
    );
  }
}

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {
      "title": "Le Paradiso",
      "id": "1",
      "lat": 36.81609433815566,
      "lon": 10.17718587414466
    },
    {
      "title": "Golden Tulip El Mechtel",
      "id": "2",
      "lat": 36.81382677960745,
      "lon": 10.173945766268655
    },
    {
      "title": "Pâtisserie Decarlo",
      "id": "3",
      "lat": 36.81360345581122,
      "lon": 10.17714295920554
    },
  ];
}
