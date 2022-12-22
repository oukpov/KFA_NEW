import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class List_pc extends StatefulWidget {
  const List_pc({super.key});

  @override
  State<List_pc> createState() => _List_pcState();
}

class _List_pcState extends State<List_pc> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  String googleApikey = "AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  Set<Polygon> _Find_polygons = HashSet<Polygon>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 50,
          title: const Text(
            "Google Map",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              setState(() {
                _Find_polygons.clear();
                Navigator.of(context).pop();
              });
            },
            icon: Icon(Icons.arrow_back_outlined, size: 25),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            GoogleMap(
              // markers: getmarkers(),

              //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              initialCameraPosition: CameraPosition(
                //innital position in map
                target: LatLng(latitude, longitude), //initial position
                zoom: 10.0, //initial zoom level
              ),
              mapType: MapType.hybrid, //map type

              onTap: (argument) {},
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
              },
              polygons: _Find_polygons,
            )
          ],
        ),
      ),
    );
  }
}
