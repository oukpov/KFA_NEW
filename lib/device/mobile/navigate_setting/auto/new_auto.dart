import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:admin/Profile/contants.dart';
import 'package:admin/components/Map.dart';
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
            Divider(
              height: 5,
              color: Colors.green[900],
              thickness: 2,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Check_map()));
                });
              },
              child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Image.asset("assets/gg_map.png")),
            ),
            Divider(
              height: 5,
              color: Colors.green[900],
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
          ],
        ),
      ),
    );
  }
}

class Check_map extends StatefulWidget {
  const Check_map({super.key});

  @override
  State<Check_map> createState() => _Check_mapState();
}

class _Check_mapState extends State<Check_map> {
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

  Set<Polygon> _polygons = HashSet<Polygon>();

  @override
  void initState() {
    super.initState();
    _setPolygons();
  }

  void _setPolygons() {
    //ខ័ណ្ឌជ្រោយចង្វា
    List<LatLng> polygonLatLongs = <LatLng>[];
    polygonLatLongs.add(LatLng(11.561098, -615.055674));
    polygonLatLongs.add(LatLng(11.563117, -615.054043));
    polygonLatLongs.add(LatLng(11.566816, -615.054559));
    polygonLatLongs.add(LatLng(11.571694, -615.054730));
    polygonLatLongs.add(LatLng(11.575057, -615.055074));
    polygonLatLongs.add(LatLng(11.580606, -615.055760));
    polygonLatLongs.add(LatLng(11.587501, -615.056619));
    polygonLatLongs.add(LatLng(11.594396, -615.058336));
    polygonLatLongs.add(LatLng(11.602299, -615.061083));
    polygonLatLongs.add(LatLng(11.608016, -615.062627));
    polygonLatLongs.add(LatLng(11.616256, -615.06589));
    polygonLatLongs.add(LatLng(11.620964, -615.06709));
    polygonLatLongs.add(LatLng(11.624999, -615.066746));
    polygonLatLongs.add(LatLng(11.629203, -615.066918));
    polygonLatLongs.add(LatLng(11.634247, -615.065201));
    polygonLatLongs.add(LatLng(11.639627, -615.064343));
    polygonLatLongs.add(LatLng(11.643494, -615.052669));
    polygonLatLongs.add(LatLng(11.647025, -615.059364));
    polygonLatLongs.add(LatLng(11.650723, -615.056617));
    polygonLatLongs.add(LatLng(11.669384, -615.054386));
    polygonLatLongs.add(LatLng(11.655767, -615.054559));
    polygonLatLongs.add(LatLng(11.659634, -615.051468));
    polygonLatLongs.add(LatLng(11.664677, -615.050095));
    polygonLatLongs.add(LatLng(11.669384, -615.04855));
    polygonLatLongs.add(LatLng(11.672579, -615.046661));
    polygonLatLongs.add(LatLng(11.677118, -615.044258));
    polygonLatLongs.add(LatLng(11.680648, -615.042541));
    polygonLatLongs.add(LatLng(11.685019, -615.040482));
    polygonLatLongs.add(LatLng(11.688044, -615.038765));
    polygonLatLongs.add(LatLng(11.692415, -615.036533));
    polygonLatLongs.add(LatLng(11.696618, -615.035332));
    polygonLatLongs.add(LatLng(11.702333, -615.033271));
    polygonLatLongs.add(LatLng(11.707039, -615.032414));
    polygonLatLongs.add(LatLng(11.711578, -615.032071));
    polygonLatLongs.add(LatLng(11.715276, -615.032243));
    polygonLatLongs.add(LatLng(11.717293, -615.034475));
    polygonLatLongs.add(LatLng(11.718973, -615.037222));
    polygonLatLongs.add(LatLng(11.720822, -615.039453));
    polygonLatLongs.add(LatLng(11.721999, -615.040654));
    polygonLatLongs.add(LatLng(11.723848, -615.042199));
    polygonLatLongs.add(LatLng(11.725361, -615.044088));
    polygonLatLongs.add(LatLng(11.726873, -615.04632));
    polygonLatLongs.add(LatLng(11.728722, -615.048207));
    polygonLatLongs.add(LatLng(11.730403, -615.051984));
    polygonLatLongs.add(LatLng(11.731748, -615.053357));
    polygonLatLongs.add(LatLng(11.732924, -615.055416));
    polygonLatLongs.add(LatLng(11.734269, -615.057649));
    polygonLatLongs.add(LatLng(11.734605, -615.064688));
    polygonLatLongs.add(LatLng(11.730571, -615.07001));
    polygonLatLongs.add(LatLng(11.727546, -615.073443));
    polygonLatLongs.add(LatLng(11.725865, -615.076361));
    polygonLatLongs.add(LatLng(11.725024, -615.078592));
    polygonLatLongs.add(LatLng(11.723848, -615.081853));
    polygonLatLongs.add(LatLng(11.723344, -615.083226));
    polygonLatLongs.add(LatLng(11.720994, -615.083054));
    polygonLatLongs.add(LatLng(11.718301, -615.083398));
    polygonLatLongs.add(LatLng(11.716452, -615.084256));
    polygonLatLongs.add(LatLng(11.714603, -615.085286));
    polygonLatLongs.add(LatLng(11.712922, -615.087175));
    polygonLatLongs.add(LatLng(11.710737, -615.088033));
    polygonLatLongs.add(LatLng(11.707712, -615.089063));
    polygonLatLongs.add(LatLng(11.705695, -615.089749));
    polygonLatLongs.add(LatLng(11.702165, -615.090436));
    polygonLatLongs.add(LatLng(11.699475, -615.090779));
    polygonLatLongs.add(LatLng(11.697962, -615.092668));
    polygonLatLongs.add(LatLng(11.695777, -615.094041));
    polygonLatLongs.add(LatLng(11.700316, -615.103143));
    polygonLatLongs.add(LatLng(11.696323, -615.118954));
    polygonLatLongs.add(LatLng(11.696618, -615.121895));
    polygonLatLongs.add(LatLng(11.704098, -615.121721));
    polygonLatLongs.add(LatLng(11.706955, -615.130652));
    polygonLatLongs.add(LatLng(11.692583, -615.135714));
    polygonLatLongs.add(LatLng(11.670477, -615.133823));
    polygonLatLongs.add(LatLng(11.670393, -615.132106));
    polygonLatLongs.add(LatLng(11.669027, -615.133492));
    polygonLatLongs.add(LatLng(11.667136, -615.132933));
    polygonLatLongs.add(LatLng(11.667115, -615.137342));
    polygonLatLongs.add(LatLng(11.659634, -615.133393));
    polygonLatLongs.add(LatLng(11.654254, -615.129446));
    polygonLatLongs.add(LatLng(11.648874, -615.125239));
    polygonLatLongs.add(LatLng(11.646352, -615.123008));
    polygonLatLongs.add(LatLng(11.643326, -615.118115));
    polygonLatLongs.add(LatLng(11.641476, -615.114768));
    polygonLatLongs.add(LatLng(11.638282, -615.107127));
    polygonLatLongs.add(LatLng(11.636432, -615.101463));
    polygonLatLongs.add(LatLng(11.634583, -615.09743));
    polygonLatLongs.add(LatLng(11.631136, -615.092537));
    polygonLatLongs.add(LatLng(11.626596, -615.088503));
    polygonLatLongs.add(LatLng(11.623486, -615.085757));
    polygonLatLongs.add(LatLng(11.618862, -615.082925));
    polygonLatLongs.add(LatLng(11.614826, -615.080608));
    polygonLatLongs.add(LatLng(11.611968, -615.079492));
    polygonLatLongs.add(LatLng(11.595237, -615.078978));
    polygonLatLongs.add(LatLng(11.588931, -615.078549));
    polygonLatLongs.add(LatLng(11.586324, -615.077776));
    polygonLatLongs.add(LatLng(11.575646, -615.072109));
    polygonLatLongs.add(LatLng(11.569255, -615.067818));
    polygonLatLongs.add(LatLng(11.567153, -615.066532));
    polygonLatLongs.add(LatLng(11.563285, -615.063613));
    polygonLatLongs.add(LatLng(11.560594, -615.060781));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Color.fromARGB(54, 139, 80, 76),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 255, 17, 0),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        mapType: MapType.hybrid,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(11.562108, 104.888535),
          zoom: 12,
        ),
        polygons: _polygons,
        myLocationEnabled: true,
        indoorViewEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
