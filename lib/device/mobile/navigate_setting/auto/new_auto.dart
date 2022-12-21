// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:collection';

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
        centerTitle: true,
        title: Text(
          "New Auto",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    child: GFButton(
                      color: Colors.green,
                      onPressed: () {},
                      text: "Edit",
                      shape: GFButtonShape.pills,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    child: GFButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Check_map()));
                      },
                      text: "Save",
                      shape: GFButtonShape.pills,
                      icon: Icon(
                        Icons.save_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit commune?',
                labelText: 'Commune',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit District?',
                labelText: 'District',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit province?',
                labelText: 'Province',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              color: Colors.blue,
              thickness: 2,
            ),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit province?',
                labelText: 'Main Road Min Value',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit province?',
                labelText: 'Sub Road Min Value',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit province?',
                labelText: 'Main Road Max Value',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
            Container(
                child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Do you want to edit province?',
                labelText: 'Sub Road Max Value',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            )),
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
// ខ័ណ្ឌព្រែកព្នៅ

    List<LatLng> Khan_Preaek_Pnov = <LatLng>[];
//1
    Khan_Preaek_Pnov.add(LatLng(11.657514, 104.866861));
    Khan_Preaek_Pnov.add(LatLng(11.665511, 104.861553));
    Khan_Preaek_Pnov.add(LatLng(11.675207, 104.853490));
    Khan_Preaek_Pnov.add(LatLng(11.682077, 104.849790));
    Khan_Preaek_Pnov.add(LatLng(11.688296, 104.846657));
    Khan_Preaek_Pnov.add(LatLng(11.699685, 104.841508));
//2

    Khan_Preaek_Pnov.add(LatLng(11.705106, 104.839533));
    Khan_Preaek_Pnov.add(LatLng(11.713721, 104.837946));
    Khan_Preaek_Pnov.add(LatLng(11.714267, 104.837688));
    Khan_Preaek_Pnov.add(LatLng(11.715402, 104.837388));
    Khan_Preaek_Pnov.add(LatLng(11.715570, 104.836744));
    Khan_Preaek_Pnov.add(LatLng(11.715696, 104.827131));

//3
    Khan_Preaek_Pnov.add(LatLng(11.715360, 104.823140));
    Khan_Preaek_Pnov.add(LatLng(11.715065, 104.822668));
    Khan_Preaek_Pnov.add(LatLng(11.713595, 104.821380));
    Khan_Preaek_Pnov.add(LatLng(11.713027, 104.822367));
    Khan_Preaek_Pnov.add(LatLng(11.711851, 104.823322));
    Khan_Preaek_Pnov.add(LatLng(11.710275, 104.824030));
//4sssssssssssssss

    Khan_Preaek_Pnov.add(LatLng(11.707985, 104.823151));
    Khan_Preaek_Pnov.add(LatLng(11.708699, 104.819331));
    Khan_Preaek_Pnov.add(LatLng(11.708405, 104.818344));
    Khan_Preaek_Pnov.add(LatLng(11.706934, 104.817743));
    Khan_Preaek_Pnov.add(LatLng(11.705673, 104.816370));

//5
    Khan_Preaek_Pnov.add(LatLng(11.703845, 104.815361));
    Khan_Preaek_Pnov.add(LatLng(11.699559, 104.815984));
    Khan_Preaek_Pnov.add(LatLng(11.697563, 104.815211));
    Khan_Preaek_Pnov.add(LatLng(11.696344, 104.815297));
    Khan_Preaek_Pnov.add(LatLng(11.694264, 104.814932));
    Khan_Preaek_Pnov.add(LatLng(11.691343, 104.814675));

//6
    Khan_Preaek_Pnov.add(LatLng(11.689263, 104.817142));
    Khan_Preaek_Pnov.add(LatLng(11.688339, 104.817057));
    Khan_Preaek_Pnov.add(LatLng(11.686363, 104.815576));
    Khan_Preaek_Pnov.add(LatLng(11.683842, 104.813108));
    Khan_Preaek_Pnov.add(LatLng(11.681299, 104.811306));
    Khan_Preaek_Pnov.add(LatLng(11.678462, 104.810083));

//7
    Khan_Preaek_Pnov.add(LatLng(11.677096, 104.810276));
    Khan_Preaek_Pnov.add(LatLng(11.675604, 104.811306));
    Khan_Preaek_Pnov.add(LatLng(11.674449, 104.812894));
    Khan_Preaek_Pnov.add(LatLng(11.673944, 104.813731));
    Khan_Preaek_Pnov.add(LatLng(11.673125, 104.812143));
    Khan_Preaek_Pnov.add(LatLng(11.672915, 104.810040));
//8

    Khan_Preaek_Pnov.add(LatLng(11.673062, 104.806156));
    Khan_Preaek_Pnov.add(LatLng(11.672739, 104.802303));
    Khan_Preaek_Pnov.add(LatLng(11.672633, 104.800679));
    Khan_Preaek_Pnov.add(LatLng(11.671802, 104.799182));
    Khan_Preaek_Pnov.add(LatLng(11.671449, 104.797143));
    Khan_Preaek_Pnov.add(LatLng(11.672315, 104.794400));
//9

    Khan_Preaek_Pnov.add(LatLng(11.671378, 104.784783));
    Khan_Preaek_Pnov.add(LatLng(11.671378, 104.781030));
    Khan_Preaek_Pnov.add(LatLng(11.669964, 104.779803));
    Khan_Preaek_Pnov.add(LatLng(11.669434, 104.776230));
    Khan_Preaek_Pnov.add(LatLng(11.667968, 104.769807));
    Khan_Preaek_Pnov.add(LatLng(11.666554, 104.766938));

//10
    Khan_Preaek_Pnov.add(LatLng(11.666095, 104.753351));
    Khan_Preaek_Pnov.add(LatLng(11.665653, 104.751492));
    Khan_Preaek_Pnov.add(LatLng(11.664928, 104.749886));
    Khan_Preaek_Pnov.add(LatLng(11.663939, 104.748605));
    Khan_Preaek_Pnov.add(LatLng(11.659795, 104.747411));
    Khan_Preaek_Pnov.add(LatLng(11.656737, 104.748241));
//11

    Khan_Preaek_Pnov.add(LatLng(11.653233, 104.747068));
    Khan_Preaek_Pnov.add(LatLng(11.653163, 104.746328));
    Khan_Preaek_Pnov.add(LatLng(11.647985, 104.742593));
    Khan_Preaek_Pnov.add(LatLng(11.641835, 104.743820));
    Khan_Preaek_Pnov.add(LatLng(11.639343, 104.744001));
    Khan_Preaek_Pnov.add(LatLng(11.635667, 104.743045));
//12

    Khan_Preaek_Pnov.add(LatLng(11.629340, 104.742034));
    Khan_Preaek_Pnov.add(LatLng(11.625682, 104.740933));
    Khan_Preaek_Pnov.add(LatLng(11.621263, 104.740266));
    Khan_Preaek_Pnov.add(LatLng(11.615908, 104.738389));
    Khan_Preaek_Pnov.add(LatLng(11.613540, 104.737234));
    Khan_Preaek_Pnov.add(LatLng(11.608043, 104.734907));

//13
    Khan_Preaek_Pnov.add(LatLng(11.606859, 104.734492));
    Khan_Preaek_Pnov.add(LatLng(11.604579, 104.734582));
    Khan_Preaek_Pnov.add(LatLng(11.600796, 104.736134));
    Khan_Preaek_Pnov.add(LatLng(11.599312, 104.736116));
    Khan_Preaek_Pnov.add(LatLng(11.596696, 104.734907));
    Khan_Preaek_Pnov.add(LatLng(11.594451, 104.733391));
//14

    Khan_Preaek_Pnov.add(LatLng(11.593408, 104.732453));
    Khan_Preaek_Pnov.add(LatLng(11.591853, 104.731677));
    Khan_Preaek_Pnov.add(LatLng(11.590288, 104.731686));
    Khan_Preaek_Pnov.add(LatLng(11.586382, 104.732841));
    Khan_Preaek_Pnov.add(LatLng(11.584420, 104.734104));
    Khan_Preaek_Pnov.add(LatLng(11.583289, 104.734447));
//15

    Khan_Preaek_Pnov.add(LatLng(11.581839, 104.735529));
    Khan_Preaek_Pnov.add(LatLng(11.583006, 104.736377));
    Khan_Preaek_Pnov.add(LatLng(11.583359, 104.737785));
    Khan_Preaek_Pnov.add(LatLng(11.583076, 104.739228));
    Khan_Preaek_Pnov.add(LatLng(11.583324, 104.740022));
//16

    Khan_Preaek_Pnov.add(LatLng(11.588839, 104.741754));
    Khan_Preaek_Pnov.add(LatLng(11.589475, 104.742332));
    Khan_Preaek_Pnov.add(LatLng(11.589528, 104.744443));
    Khan_Preaek_Pnov.add(LatLng(11.589652, 104.745363));
    Khan_Preaek_Pnov.add(LatLng(11.590624, 104.746157));
    Khan_Preaek_Pnov.add(LatLng(11.590394, 104.747186));

//17
    Khan_Preaek_Pnov.add(LatLng(11.590571, 104.748593));
    Khan_Preaek_Pnov.add(LatLng(11.591278, 104.750650));
    Khan_Preaek_Pnov.add(LatLng(11.590324, 104.751877));
    Khan_Preaek_Pnov.add(LatLng(11.591119, 104.752617));
    Khan_Preaek_Pnov.add(LatLng(11.591437, 104.753266));
    Khan_Preaek_Pnov.add(LatLng(11.590995, 104.754241));

//`18
    Khan_Preaek_Pnov.add(LatLng(11.591879, 104.754872));
    Khan_Preaek_Pnov.add(LatLng(11.591561, 104.755432));
    Khan_Preaek_Pnov.add(LatLng(11.590925, 104.755792));
    Khan_Preaek_Pnov.add(LatLng(11.590642, 104.757055));
    Khan_Preaek_Pnov.add(LatLng(11.590606, 104.757669));
    Khan_Preaek_Pnov.add(LatLng(11.590854, 104.759203));

//19
    Khan_Preaek_Pnov.add(LatLng(11.592009, 104.761172));
    Khan_Preaek_Pnov.add(LatLng(11.591925, 104.762760));
    Khan_Preaek_Pnov.add(LatLng(11.592619, 104.765421));
    Khan_Preaek_Pnov.add(LatLng(11.592892, 104.768403));
    Khan_Preaek_Pnov.add(LatLng(11.593355, 104.770485));
    Khan_Preaek_Pnov.add(LatLng(11.593880, 104.771922));
//20
    Khan_Preaek_Pnov.add(LatLng(11.594973, 104.772781));
    Khan_Preaek_Pnov.add(LatLng(11.595667, 104.773768));
    Khan_Preaek_Pnov.add(LatLng(11.597075, 104.774712));
    Khan_Preaek_Pnov.add(LatLng(11.598484, 104.775999));
    Khan_Preaek_Pnov.add(LatLng(11.598420, 104.777630));
    Khan_Preaek_Pnov.add(LatLng(11.599261, 104.778381));
//21
    Khan_Preaek_Pnov.add(LatLng(11.602603, 104.778295));
    Khan_Preaek_Pnov.add(LatLng(11.605126, 104.779733));
    Khan_Preaek_Pnov.add(LatLng(11.605357, 104.780377));
    Khan_Preaek_Pnov.add(LatLng(11.605273, 104.781707));
    Khan_Preaek_Pnov.add(LatLng(11.605966, 104.782394));
    Khan_Preaek_Pnov.add(LatLng(11.607354, 104.782995));
//22
    Khan_Preaek_Pnov.add(LatLng(11.608804, 104.784261));
    Khan_Preaek_Pnov.add(LatLng(11.609960, 104.784454));
    Khan_Preaek_Pnov.add(LatLng(11.610317, 104.786213));
    Khan_Preaek_Pnov.add(LatLng(11.609708, 104.786986));
    Khan_Preaek_Pnov.add(LatLng(11.608363, 104.789861));
    Khan_Preaek_Pnov.add(LatLng(11.603886, 104.797114));
//23
    Khan_Preaek_Pnov.add(LatLng(11.595166, 104.799492));
    Khan_Preaek_Pnov.add(LatLng(11.591319, 104.799899));
    Khan_Preaek_Pnov.add(LatLng(11.586632, 104.801015));
    Khan_Preaek_Pnov.add(LatLng(11.585475, 104.802195));
    Khan_Preaek_Pnov.add(LatLng(11.584487, 104.804084));
    Khan_Preaek_Pnov.add(LatLng(11.583205, 104.804835));
//24
    Khan_Preaek_Pnov.add(LatLng(11.581776, 104.807238));
    Khan_Preaek_Pnov.add(LatLng(11.580662, 104.808204));
    Khan_Preaek_Pnov.add(LatLng(11.579968, 104.809233));
    Khan_Preaek_Pnov.add(LatLng(11.579590, 104.810864));
    Khan_Preaek_Pnov.add(LatLng(11.579383, 104.823513));
    Khan_Preaek_Pnov.add(LatLng(11.580045, 104.824419));
//25
    Khan_Preaek_Pnov.add(LatLng(11.581970, 104.826078));
    Khan_Preaek_Pnov.add(LatLng(11.586095, 104.830033));
    Khan_Preaek_Pnov.add(LatLng(11.588545, 104.831564));
    Khan_Preaek_Pnov.add(LatLng(11.593007, 104.832636));
    Khan_Preaek_Pnov.add(LatLng(11.595844, 104.833044));
    Khan_Preaek_Pnov.add(LatLng(11.599981, 104.832534));
//26
    Khan_Preaek_Pnov.add(LatLng(11.602293, 104.832521));
    Khan_Preaek_Pnov.add(LatLng(11.605630, 104.832993));
    Khan_Preaek_Pnov.add(LatLng(11.609529, 104.832751));
    Khan_Preaek_Pnov.add(LatLng(11.612079, 104.832904));
    Khan_Preaek_Pnov.add(LatLng(11.614303, 104.833963));
    Khan_Preaek_Pnov.add(LatLng(11.617365, 104.835098));
//27
    Khan_Preaek_Pnov.add(LatLng(11.618709, 104.835851));
    Khan_Preaek_Pnov.add(LatLng(11.619421, 104.837714));
    Khan_Preaek_Pnov.add(LatLng(11.620321, 104.838620));
    Khan_Preaek_Pnov.add(LatLng(11.634705, 104.836272));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));

    //    Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));
    //  Khan_Preaek_Pnov.add(LatLng(11.560825, 104.721297));

//Khan_Russey_Keo
    List<LatLng> Khan_Russey_Keo = <LatLng>[];
    Khan_Russey_Keo.add(LatLng(11.657242, 104.866782));
    Khan_Russey_Keo.add(LatLng(11.649813, 104.856219));
    Khan_Russey_Keo.add(LatLng(11.648721, 104.857060));
    Khan_Russey_Keo.add(LatLng(11.648308, 104.857877));
    Khan_Russey_Keo.add(LatLng(11.648521, 104.861220));
    Khan_Russey_Keo.add(LatLng(11.643447, 104.863401));
    Khan_Russey_Keo.add(LatLng(11.643131, 104.865789));
    Khan_Russey_Keo.add(LatLng(11.643161, 104.867921));
    Khan_Russey_Keo.add(LatLng(11.642945, 104.868536));
    Khan_Russey_Keo.add(LatLng(11.643145, 104.868955));
    Khan_Russey_Keo.add(LatLng(11.642971, 104.869059));
    Khan_Russey_Keo.add(LatLng(11.642697, 104.869311));
    Khan_Russey_Keo.add(LatLng(11.642367, 104.870013));
    Khan_Russey_Keo.add(LatLng(11.640606, 104.871784));
    Khan_Russey_Keo.add(LatLng(11.638770, 104.872922));
    Khan_Russey_Keo.add(LatLng(11.636504, 104.873969));
    Khan_Russey_Keo.add(LatLng(11.634699, 104.874455));
    Khan_Russey_Keo.add(LatLng(11.632588, 104.874015));
    Khan_Russey_Keo.add(LatLng(11.629765, 104.871890));
    Khan_Russey_Keo.add(LatLng(11.627379, 104.871648));
    Khan_Russey_Keo.add(LatLng(11.624296, 104.872126));
    Khan_Russey_Keo.add(LatLng(11.623709, 104.872998));
    Khan_Russey_Keo.add(LatLng(11.624511, 104.875046));
    Khan_Russey_Keo.add(LatLng(11.624504, 104.875608));
    Khan_Russey_Keo.add(LatLng(11.624501, 104.875922));
    Khan_Russey_Keo.add(LatLng(11.624451, 104.877340));
    Khan_Russey_Keo.add(LatLng(11.622580, 104.877930));
    Khan_Russey_Keo.add(LatLng(11.621065, 104.878091));
    Khan_Russey_Keo.add(LatLng(11.620946, 104.878187));
    Khan_Russey_Keo.add(LatLng(11.620447, 104.878966));
    Khan_Russey_Keo.add(LatLng(11.619653, 104.879214));
    Khan_Russey_Keo.add(LatLng(11.617004, 104.881256));
    Khan_Russey_Keo.add(LatLng(11.615467, 104.882104));
    Khan_Russey_Keo.add(LatLng(11.614685, 104.882359));
    Khan_Russey_Keo.add(LatLng(11.613967, 104.883597));
    Khan_Russey_Keo.add(LatLng(11.612530, 104.885122));
    Khan_Russey_Keo.add(LatLng(11.611036, 104.885702));
    Khan_Russey_Keo.add(LatLng(11.609149, 104.885753));
    Khan_Russey_Keo.add(LatLng(11.607624, 104.885658));
    Khan_Russey_Keo.add(LatLng(11.590327, 104.896356));
    Khan_Russey_Keo.add(LatLng(11.590877, 104.897619));
    Khan_Russey_Keo.add(LatLng(11.585747, 104.900796));
    Khan_Russey_Keo.add(LatLng(11.583288, 104.907941));
    Khan_Russey_Keo.add(LatLng(11.584486, 104.911503));
    Khan_Russey_Keo.add(LatLng(11.585012, 104.914507));
    Khan_Russey_Keo.add(LatLng(11.587849, 104.914550));
    Khan_Russey_Keo.add(LatLng(11.588186, 104.915945));
    Khan_Russey_Keo.add(LatLng(11.588627, 104.918177));
    Khan_Russey_Keo.add(LatLng(11.588690, 104.919722));
    Khan_Russey_Keo.add(LatLng(11.593062, 104.919121));
    Khan_Russey_Keo.add(LatLng(11.595648, 104.919035));
    Khan_Russey_Keo.add(LatLng(11.600272, 104.919250));
    Khan_Russey_Keo.add(LatLng(11.604392, 104.919292));
    Khan_Russey_Keo.add(LatLng(11.608806, 104.919228));
    Khan_Russey_Keo.add(LatLng(11.611875, 104.918777));
    Khan_Russey_Keo.add(LatLng(11.615658, 104.917597));
    Khan_Russey_Keo.add(LatLng(11.618243, 104.916589));
    Khan_Russey_Keo.add(LatLng(11.618558, 104.916245));
    Khan_Russey_Keo.add(LatLng(11.618821, 104.916235));
    Khan_Russey_Keo.add(LatLng(11.621711, 104.914078));
    Khan_Russey_Keo.add(LatLng(11.623298, 104.912694));
    Khan_Russey_Keo.add(LatLng(11.626608, 104.909722));
    Khan_Russey_Keo.add(LatLng(11.629708, 104.906718));
    Khan_Russey_Keo.add(LatLng(11.631295, 104.904862));
    Khan_Russey_Keo.add(LatLng(11.633386, 104.901858));
    Khan_Russey_Keo.add(LatLng(11.634689, 104.899369));
    Khan_Russey_Keo.add(LatLng(11.635898, 104.896247));
    Khan_Russey_Keo.add(LatLng(11.636917, 104.893254));
    Khan_Russey_Keo.add(LatLng(11.639059, 104.886843));
    Khan_Russey_Keo.add(LatLng(11.639973, 104.884332));
    Khan_Russey_Keo.add(LatLng(11.641255, 104.881339));
    Khan_Russey_Keo.add(LatLng(11.642884, 104.878764));
    Khan_Russey_Keo.add(LatLng(11.645896, 104.875229));
    Khan_Russey_Keo.add(LatLng(11.649069, 104.872472));
    Khan_Russey_Keo.add(LatLng(11.655037, 104.868084));
    Khan_Russey_Keo.add(LatLng(11.657286, 104.866872));

//Khan_Sen_Sok
    List<LatLng> Khan_Sen_Sok = <LatLng>[];

    Khan_Sen_Sok.add(LatLng(11.634853, 104.836252));
    Khan_Sen_Sok.add(LatLng(11.649732, 104.856165));
    Khan_Sen_Sok.add(LatLng(11.648598, 104.857066));
    Khan_Sen_Sok.add(LatLng(11.648303, 104.857860));
    Khan_Sen_Sok.add(LatLng(11.648408, 104.860049));
    Khan_Sen_Sok.add(LatLng(11.648408, 104.861122));
    Khan_Sen_Sok.add(LatLng(11.648406, 104.861121));
    Khan_Sen_Sok.add(LatLng(11.645145, 104.862691));
    Khan_Sen_Sok.add(LatLng(11.643369, 104.863431));
    Khan_Sen_Sok.add(LatLng(11.643099, 104.865880));
    Khan_Sen_Sok.add(LatLng(11.643188, 104.867746));
    Khan_Sen_Sok.add(LatLng(11.643166, 104.867731));
    Khan_Sen_Sok.add(LatLng(11.640660, 104.871676));
    Khan_Sen_Sok.add(LatLng(11.636566, 104.873883));
    Khan_Sen_Sok.add(LatLng(11.634820, 104.874407));
    Khan_Sen_Sok.add(LatLng(11.632680, 104.873967));
    Khan_Sen_Sok.add(LatLng(11.629693, 104.871934));
    Khan_Sen_Sok.add(LatLng(11.627501, 104.871661));
    Khan_Sen_Sok.add(LatLng(11.624380, 104.872139));
    Khan_Sen_Sok.add(LatLng(11.623666, 104.873079));
    Khan_Sen_Sok.add(LatLng(11.624536, 104.875052));
    Khan_Sen_Sok.add(LatLng(11.624432, 104.877328));
    Khan_Sen_Sok.add(LatLng(11.622834, 104.877912));
    Khan_Sen_Sok.add(LatLng(11.621129, 104.878121));
    Khan_Sen_Sok.add(LatLng(11.620400, 104.878955));
    Khan_Sen_Sok.add(LatLng(11.619732, 104.879198));
    Khan_Sen_Sok.add(LatLng(11.615540, 104.882065));
    Khan_Sen_Sok.add(LatLng(11.614768, 104.882278));
    Khan_Sen_Sok.add(LatLng(11.614025, 104.883613));
    Khan_Sen_Sok.add(LatLng(11.612553, 104.885009));
    Khan_Sen_Sok.add(LatLng(11.611022, 104.885616));
    Khan_Sen_Sok.add(LatLng(11.608912, 104.885737));
    Khan_Sen_Sok.add(LatLng(11.607470, 104.885631));
    Khan_Sen_Sok.add(LatLng(11.590331, 104.896329));
    Khan_Sen_Sok.add(LatLng(11.561522, 104.890587));
    Khan_Sen_Sok.add(LatLng(11.561558, 104.890615));
    Khan_Sen_Sok.add(LatLng(11.559640, 104.888540));
    Khan_Sen_Sok.add(LatLng(11.558332, 104.887583));
    Khan_Sen_Sok.add(LatLng(11.556316, 104.886843));
    Khan_Sen_Sok.add(LatLng(11.555163, 104.886888));
    Khan_Sen_Sok.add(LatLng(11.553376, 104.887274));
    Khan_Sen_Sok.add(LatLng(11.551725, 104.888004));
    Khan_Sen_Sok.add(LatLng(11.550916, 104.888744));
    Khan_Sen_Sok.add(LatLng(11.550359, 104.889452));
    Khan_Sen_Sok.add(LatLng(11.549728, 104.890686));
    Khan_Sen_Sok.add(LatLng(11.549071, 104.889522));
    Khan_Sen_Sok.add(LatLng(11.548777, 104.887956));
    Khan_Sen_Sok.add(LatLng(11.548083, 104.883010));
    Khan_Sen_Sok.add(LatLng(11.547200, 104.872356));
    Khan_Sen_Sok.add(LatLng(11.546359, 104.868215));
    Khan_Sen_Sok.add(LatLng(11.545182, 104.861713));
    Khan_Sen_Sok.add(LatLng(11.550627, 104.862282));
    Khan_Sen_Sok.add(LatLng(11.554748, 104.862872));
    Khan_Sen_Sok.add(LatLng(11.560613, 104.863011));
    Khan_Sen_Sok.add(LatLng(11.567582, 104.864384));
    Khan_Sen_Sok.add(LatLng(11.567130, 104.858999));
    Khan_Sen_Sok.add(LatLng(11.566594, 104.856134));
    Khan_Sen_Sok.add(LatLng(11.566278, 104.850458));
    Khan_Sen_Sok.add(LatLng(11.566573, 104.834934));
    Khan_Sen_Sok.add(LatLng(11.572848, 104.834934));
    Khan_Sen_Sok.add(LatLng(11.575643, 104.844504));
    Khan_Sen_Sok.add(LatLng(11.585492, 104.842777));
    Khan_Sen_Sok.add(LatLng(11.616916, 104.839290));
    Khan_Sen_Sok.add(LatLng(11.634633, 104.836286));

    //Khan_Pou_Senchey
    List<LatLng> Khan_Pou_Senchey = <LatLng>[];
    Khan_Pou_Senchey.add(LatLng(11.562910, 104.863488));
    Khan_Pou_Senchey.add(LatLng(11.562447, 104.863424));
    Khan_Pou_Senchey.add(LatLng(11.561445, 104.863214));
    Khan_Pou_Senchey.add(LatLng(11.560983, 104.863129));
    Khan_Pou_Senchey.add(LatLng(11.560331, 104.863064));
    Khan_Pou_Senchey.add(LatLng(11.558208, 104.863021));
    Khan_Pou_Senchey.add(LatLng(11.557494, 104.863043));
    Khan_Pou_Senchey.add(LatLng(11.556186, 104.862997));
    Khan_Pou_Senchey.add(LatLng(11.555145, 104.862982));
    Khan_Pou_Senchey.add(LatLng(11.553525, 104.862846));
    Khan_Pou_Senchey.add(LatLng(11.552737, 104.862724));
    Khan_Pou_Senchey.add(LatLng(11.544338, 104.861586));
    Khan_Pou_Senchey.add(LatLng(11.542792, 104.861617));
    Khan_Pou_Senchey.add(LatLng(11.541617, 104.861753));
    Khan_Pou_Senchey.add(LatLng(11.539455, 104.861989));
    Khan_Pou_Senchey.add(LatLng(11.536326, 104.862242));
    Khan_Pou_Senchey.add(LatLng(11.534240, 104.862368));
    Khan_Pou_Senchey.add(LatLng(11.531517, 104.862440));
    Khan_Pou_Senchey.add(LatLng(11.528171, 104.862600));
    Khan_Pou_Senchey.add(LatLng(11.524828, 104.862857));
    Khan_Pou_Senchey.add(LatLng(11.522031, 104.863093));
    Khan_Pou_Senchey.add(LatLng(11.522116, 104.872449));
    Khan_Pou_Senchey.add(LatLng(11.521905, 104.874702));
    Khan_Pou_Senchey.add(LatLng(11.522073, 104.875624));
    Khan_Pou_Senchey.add(LatLng(11.520665, 104.876826));
    Khan_Pou_Senchey.add(LatLng(11.519067, 104.877727));
    Khan_Pou_Senchey.add(LatLng(11.517974, 104.878285));
    Khan_Pou_Senchey.add(LatLng(11.516649, 104.878435));
    Khan_Pou_Senchey.add(LatLng(11.514609, 104.877234));
    Khan_Pou_Senchey.add(LatLng(11.511308, 104.872749));
    Khan_Pou_Senchey.add(LatLng(11.509900, 104.865711));
    Khan_Pou_Senchey.add(LatLng(11.506472, 104.860861));
    Khan_Pou_Senchey.add(LatLng(11.505526, 104.857214));
    Khan_Pou_Senchey.add(LatLng(11.505589, 104.853265));
    Khan_Pou_Senchey.add(LatLng(11.505905, 104.850369));
    Khan_Pou_Senchey.add(LatLng(11.506094, 104.846034));
    Khan_Pou_Senchey.add(LatLng(11.506073, 104.843760));
    Khan_Pou_Senchey.add(LatLng(11.505884, 104.840326));
    Khan_Pou_Senchey.add(LatLng(11.504979, 104.838867));
    Khan_Pou_Senchey.add(LatLng(11.503718, 104.838095));
    Khan_Pou_Senchey.add(LatLng(11.502772, 104.838031));
    Khan_Pou_Senchey.add(LatLng(11.501300, 104.838674));
    Khan_Pou_Senchey.add(LatLng(11.500206, 104.838545));
    Khan_Pou_Senchey.add(LatLng(11.499231, 104.838615));
    Khan_Pou_Senchey.add(LatLng(11.500135, 104.836534));
    Khan_Pou_Senchey.add(LatLng(11.500198, 104.836019));
    Khan_Pou_Senchey.add(LatLng(11.500030, 104.833980));
    Khan_Pou_Senchey.add(LatLng(11.500261, 104.832328));
    Khan_Pou_Senchey.add(LatLng(11.500387, 104.830955));
    Khan_Pou_Senchey.add(LatLng(11.500219, 104.826706));
    Khan_Pou_Senchey.add(LatLng(11.499904, 104.821235));
    Khan_Pou_Senchey.add(LatLng(11.500156, 104.819690));
    Khan_Pou_Senchey.add(LatLng(11.500576, 104.818703));
    Khan_Pou_Senchey.add(LatLng(11.495635, 104.817887));
    Khan_Pou_Senchey.add(LatLng(11.494331, 104.818488));
    Khan_Pou_Senchey.add(LatLng(11.492523, 104.820076));
    Khan_Pou_Senchey.add(LatLng(11.491135, 104.820290));
    Khan_Pou_Senchey.add(LatLng(11.490294, 104.819282));
    Khan_Pou_Senchey.add(LatLng(11.489810, 104.817780));
    Khan_Pou_Senchey.add(LatLng(11.481904, 104.815505));
    Khan_Pou_Senchey.add(LatLng(11.481336, 104.813510));
    Khan_Pou_Senchey.add(LatLng(11.481042, 104.809883));
    Khan_Pou_Senchey.add(LatLng(11.480832, 104.807094));
    Khan_Pou_Senchey.add(LatLng(11.480558, 104.803403));
    Khan_Pou_Senchey.add(LatLng(11.478518, 104.799326));
    Khan_Pou_Senchey.add(LatLng(11.476458, 104.790915));
    Khan_Pou_Senchey.add(LatLng(11.476079, 104.786495));
    Khan_Pou_Senchey.add(LatLng(11.455996, 104.781130));
    Khan_Pou_Senchey.add(LatLng(11.455659, 104.779843));
    Khan_Pou_Senchey.add(LatLng(11.456143, 104.778684));
    Khan_Pou_Senchey.add(LatLng(11.457005, 104.777847));
    Khan_Pou_Senchey.add(LatLng(11.457615, 104.777740));
    Khan_Pou_Senchey.add(LatLng(11.457258, 104.776474));
    Khan_Pou_Senchey.add(LatLng(11.457090, 104.775079));
    Khan_Pou_Senchey.add(LatLng(11.457678, 104.774178));
    Khan_Pou_Senchey.add(LatLng(11.459150, 104.773813));
    Khan_Pou_Senchey.add(LatLng(11.461527, 104.774221));
    Khan_Pou_Senchey.add(LatLng(11.463819, 104.776152));
    Khan_Pou_Senchey.add(LatLng(11.464534, 104.778512));
    Khan_Pou_Senchey.add(LatLng(11.465480, 104.778727));
    Khan_Pou_Senchey.add(LatLng(11.466301, 104.778362));
    Khan_Pou_Senchey.add(LatLng(11.466763, 104.777311));
    Khan_Pou_Senchey.add(LatLng(11.466532, 104.776495));
    Khan_Pou_Senchey.add(LatLng(11.465312, 104.775444));
    Khan_Pou_Senchey.add(LatLng(11.464555, 104.774414));
    Khan_Pou_Senchey.add(LatLng(11.462993, 104.773491));
    Khan_Pou_Senchey.add(LatLng(11.462194, 104.772525));
    Khan_Pou_Senchey.add(LatLng(11.461690, 104.771302));
    Khan_Pou_Senchey.add(LatLng(11.461732, 104.769478));
    Khan_Pou_Senchey.add(LatLng(11.463414, 104.766903));
    Khan_Pou_Senchey.add(LatLng(11.463687, 104.765573));
    Khan_Pou_Senchey.add(LatLng(11.463309, 104.764500));
    Khan_Pou_Senchey.add(LatLng(11.462762, 104.763942));
    Khan_Pou_Senchey.add(LatLng(11.461227, 104.765058));
    Khan_Pou_Senchey.add(LatLng(11.459671, 104.765594));
    Khan_Pou_Senchey.add(LatLng(11.458178, 104.765079));
    Khan_Pou_Senchey.add(LatLng(11.456895, 104.762955));
    Khan_Pou_Senchey.add(LatLng(11.457084, 104.760187));
    Khan_Pou_Senchey.add(LatLng(11.458556, 104.758621));
    Khan_Pou_Senchey.add(LatLng(11.458808, 104.758106));
    Khan_Pou_Senchey.add(LatLng(11.458661, 104.756968));
    Khan_Pou_Senchey.add(LatLng(11.457562, 104.755896));
    Khan_Pou_Senchey.add(LatLng(11.456616, 104.755960));
    Khan_Pou_Senchey.add(LatLng(11.455017, 104.757698));
    Khan_Pou_Senchey.add(LatLng(11.453982, 104.759522));
    Khan_Pou_Senchey.add(LatLng(11.452699, 104.760359));
    Khan_Pou_Senchey.add(LatLng(11.451500, 104.760466));
    Khan_Pou_Senchey.add(LatLng(11.450533, 104.759683));
    Khan_Pou_Senchey.add(LatLng(11.450280, 104.757666));
    Khan_Pou_Senchey.add(LatLng(11.450974, 104.755048));
    Khan_Pou_Senchey.add(LatLng(11.451984, 104.754168));
    Khan_Pou_Senchey.add(LatLng(11.452972, 104.753718));
    Khan_Pou_Senchey.add(LatLng(11.455727, 104.753889));
    Khan_Pou_Senchey.add(LatLng(11.456253, 104.752795));
    Khan_Pou_Senchey.add(LatLng(11.456358, 104.751765));
    Khan_Pou_Senchey.add(LatLng(11.454802, 104.748396));
    Khan_Pou_Senchey.add(LatLng(11.454423, 104.746830));
    Khan_Pou_Senchey.add(LatLng(11.454718, 104.745607));
    Khan_Pou_Senchey.add(LatLng(11.454613, 104.744255));
    Khan_Pou_Senchey.add(LatLng(11.459849, 104.744641));
    Khan_Pou_Senchey.add(LatLng(11.463845, 104.744555));
    Khan_Pou_Senchey.add(LatLng(11.478123, 104.744877));
    Khan_Pou_Senchey.add(LatLng(11.479112, 104.746207));
    Khan_Pou_Senchey.add(LatLng(11.483927, 104.746336));
    Khan_Pou_Senchey.add(LatLng(11.484705, 104.748332));
    Khan_Pou_Senchey.add(LatLng(11.486493, 104.748589));
    Khan_Pou_Senchey.add(LatLng(11.486619, 104.749684));
    Khan_Pou_Senchey.add(LatLng(11.488133, 104.749855));
    Khan_Pou_Senchey.add(LatLng(11.489500, 104.749812));
    Khan_Pou_Senchey.add(LatLng(11.489121, 104.751808));
    Khan_Pou_Senchey.add(LatLng(11.489121, 104.758288));
    Khan_Pou_Senchey.add(LatLng(11.490635, 104.758782));
    Khan_Pou_Senchey.add(LatLng(11.491666, 104.758717));
    Khan_Pou_Senchey.add(LatLng(11.491497, 104.760391));
    Khan_Pou_Senchey.add(LatLng(11.491834, 104.762365));
    Khan_Pou_Senchey.add(LatLng(11.492486, 104.762794));
    Khan_Pou_Senchey.add(LatLng(11.495577, 104.762601));
    Khan_Pou_Senchey.add(LatLng(11.497490, 104.763953));
    Khan_Pou_Senchey.add(LatLng(11.499929, 104.765219));
    Khan_Pou_Senchey.add(LatLng(11.501317, 104.766700));
    Khan_Pou_Senchey.add(LatLng(11.502074, 104.767987));
    Khan_Pou_Senchey.add(LatLng(11.507310, 104.768395));
    Khan_Pou_Senchey.add(LatLng(11.515089, 104.768159));
    Khan_Pou_Senchey.add(LatLng(11.518516, 104.768159));
    Khan_Pou_Senchey.add(LatLng(11.520640, 104.764210));
    Khan_Pou_Senchey.add(LatLng(11.523605, 104.760842));
    Khan_Pou_Senchey.add(LatLng(11.527557, 104.757430));
    Khan_Pou_Senchey.add(LatLng(11.530669, 104.756035));
    Khan_Pou_Senchey.add(LatLng(11.530627, 104.754876));
    Khan_Pou_Senchey.add(LatLng(11.527431, 104.748868));
    Khan_Pou_Senchey.add(LatLng(11.528461, 104.745671));
    Khan_Pou_Senchey.add(LatLng(11.529723, 104.744384));
    Khan_Pou_Senchey.add(LatLng(11.532141, 104.744062));
    Khan_Pou_Senchey.add(LatLng(11.534558, 104.743504));
    Khan_Pou_Senchey.add(LatLng(11.536261, 104.742560));
    Khan_Pou_Senchey.add(LatLng(11.538406, 104.743396));
    Khan_Pou_Senchey.add(LatLng(11.541097, 104.743289));
    Khan_Pou_Senchey.add(LatLng(11.543830, 104.741680));
    Khan_Pou_Senchey.add(LatLng(11.545638, 104.739749));
    Khan_Pou_Senchey.add(LatLng(11.545722, 104.738654));
    Khan_Pou_Senchey.add(LatLng(11.543431, 104.735543));
    Khan_Pou_Senchey.add(LatLng(11.543725, 104.732153));
    Khan_Pou_Senchey.add(LatLng(11.544124, 104.730565));
    Khan_Pou_Senchey.add(LatLng(11.544061, 104.727861));
    Khan_Pou_Senchey.add(LatLng(11.548203, 104.727689));
    Khan_Pou_Senchey.add(LatLng(11.550999, 104.727174));
    Khan_Pou_Senchey.add(LatLng(11.554846, 104.725866));
    Khan_Pou_Senchey.add(LatLng(11.557894, 104.724406));
    Khan_Pou_Senchey.add(LatLng(11.559240, 104.722990));
    Khan_Pou_Senchey.add(LatLng(11.560669, 104.720651));
    Khan_Pou_Senchey.add(LatLng(11.562435, 104.719192));
    Khan_Pou_Senchey.add(LatLng(11.563886, 104.721767));
    Khan_Pou_Senchey.add(LatLng(11.565042, 104.722926));
    Khan_Pou_Senchey.add(LatLng(11.566829, 104.723205));
    Khan_Pou_Senchey.add(LatLng(11.568490, 104.721059));
    Khan_Pou_Senchey.add(LatLng(11.572021, 104.721274));
    Khan_Pou_Senchey.add(LatLng(11.571769, 104.717111));
    Khan_Pou_Senchey.add(LatLng(11.572021, 104.713957));
    Khan_Pou_Senchey.add(LatLng(11.572820, 104.713163));
    Khan_Pou_Senchey.add(LatLng(11.573997, 104.712626));
    Khan_Pou_Senchey.add(LatLng(11.575553, 104.712948));
    Khan_Pou_Senchey.add(LatLng(11.576120, 104.714300));
    Khan_Pou_Senchey.add(LatLng(11.575994, 104.719364));
    Khan_Pou_Senchey.add(LatLng(11.575217, 104.720737));
    Khan_Pou_Senchey.add(LatLng(11.574754, 104.722540));
    Khan_Pou_Senchey.add(LatLng(11.575111, 104.724085));
    Khan_Pou_Senchey.add(LatLng(11.576183, 104.725029));
    Khan_Pou_Senchey.add(LatLng(11.574649, 104.728398));
    Khan_Pou_Senchey.add(LatLng(11.577613, 104.731080));
    Khan_Pou_Senchey.add(LatLng(11.581481, 104.733011));
    Khan_Pou_Senchey.add(LatLng(11.581670, 104.734599));
    Khan_Pou_Senchey.add(LatLng(11.581523, 104.734749));
    Khan_Pou_Senchey.add(LatLng(11.581859, 104.735564));
    Khan_Pou_Senchey.add(LatLng(11.583057, 104.736509));
    Khan_Pou_Senchey.add(LatLng(11.583373, 104.737860));
    Khan_Pou_Senchey.add(LatLng(11.583226, 104.738611));
    Khan_Pou_Senchey.add(LatLng(11.582973, 104.739169));
    Khan_Pou_Senchey.add(LatLng(11.583289, 104.740092));
    Khan_Pou_Senchey.add(LatLng(11.587430, 104.741058));
    Khan_Pou_Senchey.add(LatLng(11.589448, 104.742238));
    Khan_Pou_Senchey.add(LatLng(11.589532, 104.744362));
    Khan_Pou_Senchey.add(LatLng(11.589763, 104.745456));
    Khan_Pou_Senchey.add(LatLng(11.590520, 104.746143));
    Khan_Pou_Senchey.add(LatLng(11.590393, 104.747216));
    Khan_Pou_Senchey.add(LatLng(11.591192, 104.750714));
    Khan_Pou_Senchey.add(LatLng(11.590246, 104.751915));
    Khan_Pou_Senchey.add(LatLng(11.591066, 104.752666));
    Khan_Pou_Senchey.add(LatLng(11.591402, 104.753353));
    Khan_Pou_Senchey.add(LatLng(11.590898, 104.754318));
    Khan_Pou_Senchey.add(LatLng(11.591802, 104.754898));
    Khan_Pou_Senchey.add(LatLng(11.591571, 104.755434));
    Khan_Pou_Senchey.add(LatLng(11.590856, 104.755842));
    Khan_Pou_Senchey.add(LatLng(11.590667, 104.757215));
    Khan_Pou_Senchey.add(LatLng(11.590772, 104.758996));
    Khan_Pou_Senchey.add(LatLng(11.591613, 104.760133));
    Khan_Pou_Senchey.add(LatLng(11.592012, 104.762236));
    Khan_Pou_Senchey.add(LatLng(11.591907, 104.762880));
    Khan_Pou_Senchey.add(LatLng(11.592601, 104.765584));
    Khan_Pou_Senchey.add(LatLng(11.592832, 104.768223));
    Khan_Pou_Senchey.add(LatLng(11.593294, 104.770605));
    Khan_Pou_Senchey.add(LatLng(11.593946, 104.772000));
    Khan_Pou_Senchey.add(LatLng(11.594892, 104.772751));
    Khan_Pou_Senchey.add(LatLng(11.595669, 104.773823));
    Khan_Pou_Senchey.add(LatLng(11.596931, 104.774639));
    Khan_Pou_Senchey.add(LatLng(11.598444, 104.776077));
    Khan_Pou_Senchey.add(LatLng(11.598486, 104.777729));
    Khan_Pou_Senchey.add(LatLng(11.599285, 104.778394));
    Khan_Pou_Senchey.add(LatLng(11.602606, 104.778394));
    Khan_Pou_Senchey.add(LatLng(11.605107, 104.779810));
    Khan_Pou_Senchey.add(LatLng(11.605401, 104.780518));
    Khan_Pou_Senchey.add(LatLng(11.605170, 104.781763));
    Khan_Pou_Senchey.add(LatLng(11.605864, 104.782407));
    Khan_Pou_Senchey.add(LatLng(11.607209, 104.782986));
    Khan_Pou_Senchey.add(LatLng(11.608785, 104.784316));
    Khan_Pou_Senchey.add(LatLng(11.610005, 104.784359));
    Khan_Pou_Senchey.add(LatLng(11.610446, 104.785067));
    Khan_Pou_Senchey.add(LatLng(11.610341, 104.786205));
    Khan_Pou_Senchey.add(LatLng(11.609584, 104.787127));
    Khan_Pou_Senchey.add(LatLng(11.608428, 104.789917));
    Khan_Pou_Senchey.add(LatLng(11.606957, 104.792041));
    Khan_Pou_Senchey.add(LatLng(11.603888, 104.797148));
    Khan_Pou_Senchey.add(LatLng(11.601429, 104.798371));
    Khan_Pou_Senchey.add(LatLng(11.595606, 104.799422));
    Khan_Pou_Senchey.add(LatLng(11.591276, 104.799852));
    Khan_Pou_Senchey.add(LatLng(11.586589, 104.801010));
    Khan_Pou_Senchey.add(LatLng(11.585412, 104.802298));
    Khan_Pou_Senchey.add(LatLng(11.584445, 104.804336));
    Khan_Pou_Senchey.add(LatLng(11.581691, 104.807383));
    Khan_Pou_Senchey.add(LatLng(11.579841, 104.809250));
    Khan_Pou_Senchey.add(LatLng(11.579589, 104.811074));
    Khan_Pou_Senchey.add(LatLng(11.579610, 104.814421));
    Khan_Pou_Senchey.add(LatLng(11.579274, 104.820043));
    Khan_Pou_Senchey.add(LatLng(11.579421, 104.823412));
    Khan_Pou_Senchey.add(LatLng(11.579925, 104.824313));
    Khan_Pou_Senchey.add(LatLng(11.586084, 104.830085));
    Khan_Pou_Senchey.add(LatLng(11.588291, 104.831437));
    Khan_Pou_Senchey.add(LatLng(11.592222, 104.832532));
    Khan_Pou_Senchey.add(LatLng(11.595922, 104.833090));
    Khan_Pou_Senchey.add(LatLng(11.599768, 104.832532));
    Khan_Pou_Senchey.add(LatLng(11.602291, 104.832489));
    Khan_Pou_Senchey.add(LatLng(11.605633, 104.833047));
    Khan_Pou_Senchey.add(LatLng(11.609185, 104.832875));
    Khan_Pou_Senchey.add(LatLng(11.612106, 104.832982));
    Khan_Pou_Senchey.add(LatLng(11.614713, 104.834162));
    Khan_Pou_Senchey.add(LatLng(11.617592, 104.835192));
    Khan_Pou_Senchey.add(LatLng(11.618475, 104.835900));
    Khan_Pou_Senchey.add(LatLng(11.619358, 104.837703));
    Khan_Pou_Senchey.add(LatLng(11.620430, 104.838840));
    Khan_Pou_Senchey.add(LatLng(11.585328, 104.842917));
    Khan_Pou_Senchey.add(LatLng(11.575763, 104.844612));
    Khan_Pou_Senchey.add(LatLng(11.572862, 104.835042));
    Khan_Pou_Senchey.add(LatLng(11.566598, 104.834956));
    Khan_Pou_Senchey.add(LatLng(11.566451, 104.850985));
    Khan_Pou_Senchey.add(LatLng(11.566598, 104.854011));
    Khan_Pou_Senchey.add(LatLng(11.567375, 104.859719));
    Khan_Pou_Senchey.add(LatLng(11.567796, 104.864418));
    Khan_Pou_Senchey.add(LatLng(11.562910, 104.863488));

// Daun Penh



List<LatLng> Daun_Penh = <LatLng>[];
      Daun_Penh.add(LatLng(11.587316, 104.922129));
      Daun_Penh.add(LatLng(11.585695, 104.922913));
      Daun_Penh.add(LatLng(11.581573, 104.925674));
      Daun_Penh.add(LatLng(11.577694, 104.927814));
      Daun_Penh.add(LatLng(11.573502, 104.930742));
      Daun_Penh.add(LatLng(11.567096, 104.934869));
      Daun_Penh.add(LatLng(11.564896, 104.937084));
      Daun_Penh.add(LatLng(11.563112, 104.939558));
      Daun_Penh.add(LatLng(11.562101, 104.942486));
      Daun_Penh.add(LatLng(11.563109, 104.945922));
      Daun_Penh.add(LatLng(11.560484, 104.948308));
      Daun_Penh.add(LatLng(11.558106, 104.951476));
      Daun_Penh.add(LatLng(11.557132, 104.936986));
      Daun_Penh.add(LatLng(11.557161, 104.932630));
      Daun_Penh.add(LatLng(11.556596, 104.929158));
      Daun_Penh.add(LatLng(11.556310, 104.924772));
      Daun_Penh.add(LatLng(11.556179, 104.922916));
      Daun_Penh.add(LatLng(11.555909, 104.919497));
      Daun_Penh.add(LatLng(11.559082, 104.921682));
      Daun_Penh.add(LatLng(11.562315, 104.919126));
      Daun_Penh.add(LatLng(11.562321, 104.919676));
      Daun_Penh.add(LatLng(11.566566, 104.918864));
      Daun_Penh.add(LatLng(11.567324, 104.918514));
      Daun_Penh.add(LatLng(11.566902, 104.918093));
      Daun_Penh.add(LatLng(11.566933, 104.918067));
      Daun_Penh.add(LatLng(11.571901, 104.918879));
      Daun_Penh.add(LatLng(11.571109, 104.915673));
      Daun_Penh.add(LatLng(11.570503, 104.905888));
      Daun_Penh.add(LatLng(11.573725, 104.904299));
      Daun_Penh.add(LatLng(11.577518, 104.903499));
      Daun_Penh.add(LatLng(11.580096, 104.905703));
      Daun_Penh.add(LatLng(11.582892, 104.907468));
      Daun_Penh.add(LatLng(11.584302, 104.910725));
      Daun_Penh.add(LatLng(11.586276, 104.914412));
      Daun_Penh.add(LatLng(11.587420, 104.915685));
      Daun_Penh.add(LatLng(11.588464, 104.916797));
      Daun_Penh.add(LatLng(11.589483, 104.921067));
      Daun_Penh.add(LatLng(11.587316, 104.922129));


// Daun Penh
      List<LatLng> K7_Makara = <LatLng>[];
      K7_Makara.add(LatLng(11.570400, 104.906354));
      K7_Makara.add(LatLng(11.571505, 104.918507));
      K7_Makara.add(LatLng(11.567190, 104.918613));
      K7_Makara.add(LatLng(11.555896, 104.920561));
      K7_Makara.add(LatLng(11.555639, 104.918249));
      K7_Makara.add(LatLng(11.555635, 104.911449));
      K7_Makara.add(LatLng(11.555773, 104.910608));
      K7_Makara.add(LatLng(11.557696, 104.908259));
      K7_Makara.add(LatLng(11.570400, 104.906354));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Color.fromARGB(54, 139, 80, 76),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 255, 17, 0),
      ),
    );
    _polygons.add(
      Polygon(
        polygonId: PolygonId("1"),
        points: Khan_Preaek_Pnov,
        fillColor: Color.fromARGB(123, 93, 78, 175),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 140, 0, 255),
      ),
    );
    _polygons.add(
      Polygon(
        polygonId: PolygonId("2"),
        points: Khan_Russey_Keo,
        fillColor: Color.fromARGB(150, 64, 175, 80),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 192, 116, 22),
      ),
    );
    _polygons.add(
      Polygon(
        polygonId: PolygonId("3"),
        points: Khan_Sen_Sok,
        fillColor: Color.fromARGB(108, 104, 203, 228),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 43, 4, 212),
       
      ),
    );
     _polygons.add(
      Polygon(
        polygonId: PolygonId("4"),
        points: Daun_Penh,
       fillColor: Color.fromARGB(121, 1, 255, 14),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 192, 116, 22),
      ),
    );

     _polygons.add(
      Polygon(
        polygonId: PolygonId("5"),
        points: K7_Makara,
        fillColor: Color.fromARGB(146, 224, 103, 33),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 25, 4, 116),
      ),
    );
     _polygons.add(
      Polygon(
        polygonId: PolygonId("6"),
        points: Khan_Pou_Senchey,
       fillColor: Color.fromARGB(121, 1, 255, 14),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 192, 116, 22),
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
