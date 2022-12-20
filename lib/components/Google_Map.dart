// ignore_for_file: file_names, camel_case_types, unused_field, use_build_context_synchronously, unnecessary_new, prefer_collection_literals, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Google_Map extends StatefulWidget {
  const Google_Map({super.key});

  @override
  State<Google_Map> createState() => _Google_MapState();
}

class _Google_MapState extends State<Google_Map> {
  String? _currentAddress;
  Position? _currentPosition;
// use for check user access to the location
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        lat = _currentPosition!.latitude;
        log = _currentPosition!.longitude;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future showLocation() async {}
  late GoogleMapController mapController;
  dynamic lat, log;
  final Set<Marker> markers = new Set();

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: ((lat != null)
            ? map(context)
            : const Center(
                child: Text("Fetching user order..."),
              )),
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add second marker
        markerId: MarkerId("showLocation.toString()"),
        position: LatLng(lat, log), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Thanks for using us',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  void show() {
    Future.delayed(
      const Duration(seconds: 2),
      () => map(context),
    );
  }

  Widget map(BuildContext context) {
    return GoogleMap(
      //Map widget from google_maps_flutter package
      zoomGesturesEnabled: true, //enable Zoom in, out on map
      initialCameraPosition: CameraPosition(
        //innital position in map
        target: LatLng(lat, log), //initial position
        zoom: 15.0, //initial zoom level
      ),
      markers: getmarkers(), //markers to show on map
      mapType: MapType.hybrid, //map type
      onMapCreated: (controller) {
        //method called when map is created
        setState(() {
          mapController = controller;
        });
      },
    );
  }
}



// GoogleMap(
//                     //Map widget from google_maps_flutter package
//                     zoomGesturesEnabled: true, //enable Zoom in, out on map
//                     initialCameraPosition: CameraPosition(
//                       //innital position in map
//                       target: LatLng(lat, log), //initial position
//                       zoom: 15.0, //initial zoom level
//                     ),
//                     markers: getmarkers(), //markers to show on map
//                     mapType: MapType.hybrid, //map type
//                     onMapCreated: (controller) {
//                       //method called when map is created
//                       setState(() {
//                         mapController = controller;
//                       });
//                     },
//                   ),