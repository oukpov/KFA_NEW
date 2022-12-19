import 'dart:ui';

import 'package:admin/Profile/contants.dart';
import 'package:admin/components/slideUp.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';

class NewAuto extends StatefulWidget {
  const NewAuto({super.key});

  @override
  State<NewAuto> createState() => _NewAutoState();
}

class _NewAutoState extends State<NewAuto> {
  String googleApikey = "AIzaSyAJt0Zghbk3qm_ZClIQOYeUT0AaV5TeOsI";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  double latitude = 11.5489; //latitude
  double longitude = 104.9214;
  LatLng latLng = const LatLng(11.5489, 104.9214);
  String address = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List list = [];
  // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);

  ///converts `coordinates` to actual `address` using google map api
  Future<void> getAddress(double lat, double lng) async {
    try {
      final address =
          await geocoder.findAddressesFromCoordinates(Coordinates(lat, lng));
      var message = address.first.addressLine;
      if (message == null) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  ///converts `address` to actual `coordinates` using google map api
  Future<void> getLatLang(String adds) async {
    try {
      final address = await geocoder.findAddressesFromQuery(adds);
      var message = address.first.coordinates.toString();
      latitude = address.first.coordinates.latitude!;
      longitude = address.first.coordinates.longitude!;
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 10)));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  @override
  void initState() {
    getAddress(latitude, longitude); //call convert to address
    super.initState();
    // Load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "New Auto",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        actions: [
          GFButton(
            onPressed: () {},
            color: Color.fromARGB(255, 23, 11, 179),
            text: "Save",
            shape: GFButtonShape.standard,
            icon: const Icon(
              Icons.save_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.travel_explore,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit commune?',
                  labelText: 'Commune',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.travel_explore,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit District?',
                  labelText: 'District',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.travel_explore,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit province?',
                  labelText: 'Province',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: GoogleMap(
                //   markers: getmarkers(),
                markers: Set<Marker>.of(markers.values),
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: LatLng(latitude, longitude), //initial position
                  zoom: 10.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                onTap: (argument) {
                  MarkerId markerId = MarkerId('mark');
                  listMarkerIds.add(markerId);
                  Marker marker = Marker(
                    markerId: MarkerId('mark'),
                    position: argument,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  );
                  setState(() {
                    markers[markerId] = marker;
                    // getAddress(argument);
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona; //when map is dragging
                },
                onCameraIdle: () {
                  //when map drag stops
                  // getAddress(cameraPosition!.target.latitude,
                  //     cameraPosition!.target.longitude);
                  setState(() {
                    //get place name from lat and lang
                  });
                },
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.blue,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.density_large,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit province?',
                  labelText: 'Main Road Min Value',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.remove,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit province?',
                  labelText: 'Sub Road Min Value',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.density_large,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit province?',
                  labelText: 'Main Road Max Value',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.remove,
                    size: 40,
                    shadows: [Shadow(blurRadius: 2, color: Colors.green)],
                  ),
                  hintText: 'Do you want to edit province?',
                  labelText: 'Sub Road Max Value',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ),
            SizedBox(
              height: 500,
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> getAddress(LatLng latLng) async {
  //   final coordinates = Coordinates(latLng.latitude, latLng.longitude);
  //   try {
  //     final address = await geocoder.findAddressesFromCoordinates(coordinates);
  //     var message = address.first.addressLine;
  //     if (message == null) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
  //       ),
  //     );
  //     rethrow;
  //   }
}
