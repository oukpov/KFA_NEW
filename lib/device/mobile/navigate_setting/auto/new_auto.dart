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
//////////////////////////1
    List<LatLng> Khan_Preaek_Pnov = <LatLng>[];
    Khan_Preaek_Pnov.add(LatLng(11.658289, 104.867638));
    Khan_Preaek_Pnov.add(LatLng(11.684094, 104.851412));
    Khan_Preaek_Pnov.add(LatLng(11.704518, 104.842485));
    Khan_Preaek_Pnov.add(LatLng(11.712943, 104.840888));
//////////////////////////2
    Khan_Preaek_Pnov.add(LatLng(11.713427, 104.838484));
    Khan_Preaek_Pnov.add(LatLng(11.713112, 104.837374));
    Khan_Preaek_Pnov.add(LatLng(11.712092, 104.836687));
    Khan_Preaek_Pnov.add(LatLng(11.712061, 104.836642));
//////////////////////////3
    Khan_Preaek_Pnov.add(LatLng(11.711205, 104.835596));
    Khan_Preaek_Pnov.add(LatLng(11.711294, 104.83471));
    Khan_Preaek_Pnov.add(LatLng(11.712087, 104.833648));
    Khan_Preaek_Pnov.add(LatLng(11.714482, 104.832919));
//////////////////////////4
    Khan_Preaek_Pnov.add(LatLng(11.715339, 104.831245));
    Khan_Preaek_Pnov.add(LatLng(11.716662, 104.830872));
    Khan_Preaek_Pnov.add(LatLng(11.717891, 104.8301));
    Khan_Preaek_Pnov.add(LatLng(11.718165, 104.828748));
//////////////////////////5
    Khan_Preaek_Pnov.add(LatLng(11.718007, 104.826441));
    Khan_Preaek_Pnov.add(LatLng(11.715769, 104.824488));
    Khan_Preaek_Pnov.add(LatLng(11.715118, 104.822536));
    Khan_Preaek_Pnov.add(LatLng(11.713511, 104.821347));
//////////////////////////6
    Khan_Preaek_Pnov.add(LatLng(11.713088, 104.822296));
    Khan_Preaek_Pnov.add(LatLng(11.711877, 104.823294));
    Khan_Preaek_Pnov.add(LatLng(11.710081, 104.824084));
    Khan_Preaek_Pnov.add(LatLng(11.708699, 104.824186));
//////////////////////////7
    Khan_Preaek_Pnov.add(LatLng(11.707898, 104.823149));
    Khan_Preaek_Pnov.add(LatLng(11.708815, 104.822095));
    Khan_Preaek_Pnov.add(LatLng(11.708295, 104.820311));
    Khan_Preaek_Pnov.add(LatLng(11.708762, 104.819286));
//////////////////////////8
    Khan_Preaek_Pnov.add(LatLng(11.708442, 104.818211));
    Khan_Preaek_Pnov.add(LatLng(11.706892, 104.817658));
    Khan_Preaek_Pnov.add(LatLng(11.705658, 104.816242));
    Khan_Preaek_Pnov.add(LatLng(11.703788, 104.815291));
//////////////////////////9

    Khan_Preaek_Pnov.add(LatLng(11.701545, 104.815411));
    Khan_Preaek_Pnov.add(LatLng(11.699617, 104.815871));
    Khan_Preaek_Pnov.add(LatLng(11.697952, 104.815265));
    Khan_Preaek_Pnov.add(LatLng(11.696407, 104.815118));
//////////////////////////10

    Khan_Preaek_Pnov.add(LatLng(11.694117, 104.814795));
    Khan_Preaek_Pnov.add(LatLng(11.691385, 104.814554));
    Khan_Preaek_Pnov.add(LatLng(11.690151, 104.815936));
    Khan_Preaek_Pnov.add(LatLng(11.689308, 104.817076));
//////////////////////////11

    Khan_Preaek_Pnov.add(LatLng(11.688304, 104.816961));
    Khan_Preaek_Pnov.add(LatLng(11.686132, 104.815197));
    Khan_Preaek_Pnov.add(LatLng(11.683821, 104.812944));
    Khan_Preaek_Pnov.add(LatLng(11.681488, 104.811195));
//////////////////////////12

    Khan_Preaek_Pnov.add(LatLng(11.678547, 104.80994));
    Khan_Preaek_Pnov.add(LatLng(11.677125, 104.810159));
    Khan_Preaek_Pnov.add(LatLng(11.675626, 104.811226));
    Khan_Preaek_Pnov.add(LatLng(11.674312, 104.812953));
//////////////////////////13

    Khan_Preaek_Pnov.add(LatLng(11.673926, 104.813686));
    Khan_Preaek_Pnov.add(LatLng(11.673209, 104.812051));
    Khan_Preaek_Pnov.add(LatLng(11.673093, 104.806399));
    Khan_Preaek_Pnov.add(LatLng(11.672618, 104.800538));
//////////////////////////14
    Khan_Preaek_Pnov.add(LatLng(11.671833, 104.798951));
    Khan_Preaek_Pnov.add(LatLng(11.671507, 104.797052));
    Khan_Preaek_Pnov.add(LatLng(11.672392, 104.794243));
    Khan_Preaek_Pnov.add(LatLng(11.672101, 104.789016));
//////////////////////////15
    Khan_Preaek_Pnov.add(LatLng(11.671475, 104.784695));
    Khan_Preaek_Pnov.add(LatLng(11.671339, 104.780221));
    Khan_Preaek_Pnov.add(LatLng(11.669132, 104.780061));
    Khan_Preaek_Pnov.add(LatLng(11.667938, 104.769954));
//////////////////////////16
    Khan_Preaek_Pnov.add(LatLng(11.667965, 104.769652));
    Khan_Preaek_Pnov.add(LatLng(11.667257, 104.766399));
    Khan_Preaek_Pnov.add(LatLng(11.666062, 104.753212));
    Khan_Preaek_Pnov.add(LatLng(11.666062, 104.752721));
//////////////////////////17
    Khan_Preaek_Pnov.add(LatLng(11.662363, 104.749973));
    Khan_Preaek_Pnov.add(LatLng(11.659874, 104.747318));
    Khan_Preaek_Pnov.add(LatLng(11.658981, 104.747039));
    Khan_Preaek_Pnov.add(LatLng(11.657983, 104.747146));
//////////////////////////18
    Khan_Preaek_Pnov.add(LatLng(11.657289, 104.747307));
    Khan_Preaek_Pnov.add(LatLng(11.655619, 104.747468));
    Khan_Preaek_Pnov.add(LatLng(11.654043, 104.747768));
    Khan_Preaek_Pnov.add(LatLng(11.651983, 104.747811));
//////////////////////////19
    Khan_Preaek_Pnov.add(LatLng(11.649071, 104.746155));
    Khan_Preaek_Pnov.add(LatLng(11.646908, 104.745322));
    Khan_Preaek_Pnov.add(LatLng(11.645531, 104.744163));
    Khan_Preaek_Pnov.add(LatLng(11.643646, 104.744407));
//////////////////////////20
    Khan_Preaek_Pnov.add(LatLng(11.641611, 104.744528));
    Khan_Preaek_Pnov.add(LatLng(11.639341, 104.744496));
    Khan_Preaek_Pnov.add(LatLng(11.635013, 104.744616));
    Khan_Preaek_Pnov.add(LatLng(11.629493, 104.741841));
//////////////////////////21
    Khan_Preaek_Pnov.add(LatLng(11.625722, 104.74088));
    Khan_Preaek_Pnov.add(LatLng(11.623541, 104.740543));
    Khan_Preaek_Pnov.add(LatLng(11.622103, 104.739969));
    Khan_Preaek_Pnov.add(LatLng(11.619469, 104.739207));
//////////////////////////22

    Khan_Preaek_Pnov.add(LatLng(11.606827, 104.734421));
    Khan_Preaek_Pnov.add(LatLng(11.603043, 104.734647));
    Khan_Preaek_Pnov.add(LatLng(11.601557, 104.735384));
    Khan_Preaek_Pnov.add(LatLng(11.600353, 104.735731));
//////////////////////////23

    Khan_Preaek_Pnov.add(LatLng(11.596407, 104.733941));
    Khan_Preaek_Pnov.add(LatLng(11.591899, 104.731597));
    Khan_Preaek_Pnov.add(LatLng(11.590301, 104.731561));
    Khan_Preaek_Pnov.add(LatLng(11.587629, 104.732357));
//////////////////////////24
///////////////////////////////
    Khan_Preaek_Pnov.add(LatLng(11.586427, 104.732812));
    Khan_Preaek_Pnov.add(LatLng(11.585591, 104.733352));
    Khan_Preaek_Pnov.add(LatLng(11.585841, 104.734316));
    Khan_Preaek_Pnov.add(LatLng(11.588107, 104.734552));

//////////////////////////26
    Khan_Preaek_Pnov.add(LatLng(11.588699, 104.735278));
    Khan_Preaek_Pnov.add(LatLng(11.589222, 104.736746));
    Khan_Preaek_Pnov.add(LatLng(11.589204, 104.739205));
    Khan_Preaek_Pnov.add(LatLng(11.589897, 104.739844));
//////////////////////////26
    Khan_Preaek_Pnov.add(LatLng(11.590208, 104.740696));
    Khan_Preaek_Pnov.add(LatLng(11.589246, 104.742064));
    Khan_Preaek_Pnov.add(LatLng(11.589834, 104.745423));
    Khan_Preaek_Pnov.add(LatLng(11.590428, 104.746275));
//////////////////////////27
    Khan_Preaek_Pnov.add(LatLng(11.589966, 104.747075));
    Khan_Preaek_Pnov.add(LatLng(11.589792, 104.748086));
    Khan_Preaek_Pnov.add(LatLng(11.589966, 104.749719));
    Khan_Preaek_Pnov.add(LatLng(11.590843, 104.75031));
//////////////////////////28
    Khan_Preaek_Pnov.add(LatLng(11.590927, 104.750709));
    Khan_Preaek_Pnov.add(LatLng(11.590765, 104.751348));
    Khan_Preaek_Pnov.add(LatLng(11.590129, 104.751747));
    Khan_Preaek_Pnov.add(LatLng(11.589467, 104.752715));
//////////////////////////29
    Khan_Preaek_Pnov.add(LatLng(11.589929, 104.756028));
    Khan_Preaek_Pnov.add(LatLng(11.589858, 104.757205));
    Khan_Preaek_Pnov.add(LatLng(11.590355, 104.758089));
    Khan_Preaek_Pnov.add(LatLng(11.590539, 104.759469));
//////////////////////////30
    Khan_Preaek_Pnov.add(LatLng(11.591911, 104.760627));
    Khan_Preaek_Pnov.add(LatLng(11.592017, 104.761304));
    Khan_Preaek_Pnov.add(LatLng(11.592039, 104.762833));
    Khan_Preaek_Pnov.add(LatLng(11.592725, 104.765491));
//////////////////////////31
    Khan_Preaek_Pnov.add(LatLng(11.592677, 104.766145));
    Khan_Preaek_Pnov.add(LatLng(11.592922, 104.768327));
    Khan_Preaek_Pnov.add(LatLng(11.593393, 104.770489));
    Khan_Preaek_Pnov.add(LatLng(11.593849, 104.771831));
//////////////////////////32
    Khan_Preaek_Pnov.add(LatLng(11.595016, 104.772684));
    Khan_Preaek_Pnov.add(LatLng(11.595557, 104.773677));
    Khan_Preaek_Pnov.add(LatLng(11.597018, 104.774584));
    Khan_Preaek_Pnov.add(LatLng(11.598474, 104.775978));
//////////////////////////33
    Khan_Preaek_Pnov.add(LatLng(11.598437, 104.777534));
    Khan_Preaek_Pnov.add(LatLng(11.599325, 104.778253));
    Khan_Preaek_Pnov.add(LatLng(11.602567, 104.778239));
    Khan_Preaek_Pnov.add(LatLng(11.605158, 104.779808));
//////////////////////////34
    Khan_Preaek_Pnov.add(LatLng(11.605473, 104.780302));
    Khan_Preaek_Pnov.add(LatLng(11.605315, 104.781825));
    Khan_Preaek_Pnov.add(LatLng(11.605893, 104.782341));
    Khan_Preaek_Pnov.add(LatLng(11.606293, 104.783306));
//////////////////////////35
    Khan_Preaek_Pnov.add(LatLng(11.606245, 104.784637));
    Khan_Preaek_Pnov.add(LatLng(11.604522, 104.788698));
    Khan_Preaek_Pnov.add(LatLng(11.603886, 104.791525));
    Khan_Preaek_Pnov.add(LatLng(11.600922, 104.797479));
//////////////////////////36
    Khan_Preaek_Pnov.add(LatLng(11.602162, 104.798745));
    Khan_Preaek_Pnov.add(LatLng(11.601815, 104.801631));
    Khan_Preaek_Pnov.add(LatLng(11.599708, 104.801191));
    Khan_Preaek_Pnov.add(LatLng(11.599468, 104.803159));
//////////////////////////37
    Khan_Preaek_Pnov.add(LatLng(11.596626, 104.802546));
    Khan_Preaek_Pnov.add(LatLng(11.591067, 104.80077));
    Khan_Preaek_Pnov.add(LatLng(11.591217, 104.801985));
    Khan_Preaek_Pnov.add(LatLng(11.589556, 104.802763));
//////////////////////////38
    Khan_Preaek_Pnov.add(LatLng(11.587534, 104.802918));
    Khan_Preaek_Pnov.add(LatLng(11.585459, 104.803305));
    Khan_Preaek_Pnov.add(LatLng(11.584621, 104.804177));
    Khan_Preaek_Pnov.add(LatLng(11.584293, 104.807046));
//////////////////////////39
    Khan_Preaek_Pnov.add(LatLng(11.583966, 104.808013));
    Khan_Preaek_Pnov.add(LatLng(11.583189, 104.808779));
    Khan_Preaek_Pnov.add(LatLng(11.582787, 104.810702));
    Khan_Preaek_Pnov.add(LatLng(11.582151, 104.811367));
//////////////////////////40
    Khan_Preaek_Pnov.add(LatLng(11.582083, 104.817852));
    Khan_Preaek_Pnov.add(LatLng(11.578943, 104.818025));
    Khan_Preaek_Pnov.add(LatLng(11.578967, 104.820052));
    Khan_Preaek_Pnov.add(LatLng(11.580704, 104.822772));
    //////////////////////////41

    Khan_Preaek_Pnov.add(LatLng(11.581027, 104.824124));
    Khan_Preaek_Pnov.add(LatLng(11.582463, 104.824327));
    Khan_Preaek_Pnov.add(LatLng(11.583172, 104.824792));
    Khan_Preaek_Pnov.add(LatLng(11.584462, 104.824653));
    //////////////////////////42
    Khan_Preaek_Pnov.add(LatLng(11.587575, 104.823615));
    Khan_Preaek_Pnov.add(LatLng(11.588171, 104.824972));
    Khan_Preaek_Pnov.add(LatLng(11.588187, 104.826361));
    Khan_Preaek_Pnov.add(LatLng(11.588521, 104.828614));
    //////////////////////////43
    Khan_Preaek_Pnov.add(LatLng(11.590066, 104.828847));
    Khan_Preaek_Pnov.add(LatLng(11.589882, 104.830084));
    Khan_Preaek_Pnov.add(LatLng(11.591281, 104.830984));
    Khan_Preaek_Pnov.add(LatLng(11.592446, 104.831157));
    //////////////////////////44
    Khan_Preaek_Pnov.add(LatLng(11.593297, 104.83179));
    Khan_Preaek_Pnov.add(LatLng(11.594463, 104.831355));
    Khan_Preaek_Pnov.add(LatLng(11.595394, 104.831328));
    Khan_Preaek_Pnov.add(LatLng(11.599112, 104.832192));
    //////////////////////////45
    Khan_Preaek_Pnov.add(LatLng(11.599672, 104.834547));
    Khan_Preaek_Pnov.add(LatLng(11.601871, 104.834389));
    Khan_Preaek_Pnov.add(LatLng(11.603149, 104.835165));
    Khan_Preaek_Pnov.add(LatLng(11.604203, 104.835124));
    //////////////////////////46
    Khan_Preaek_Pnov.add(LatLng(11.605105, 104.834665));
    Khan_Preaek_Pnov.add(LatLng(11.608221, 104.834947));
    Khan_Preaek_Pnov.add(LatLng(11.608899, 104.835641));
    Khan_Preaek_Pnov.add(LatLng(11.609036, 104.836414));
    //////////////////////////47

    Khan_Preaek_Pnov.add(LatLng(11.609918, 104.836682));
    Khan_Preaek_Pnov.add(LatLng(11.610002, 104.837733));
    Khan_Preaek_Pnov.add(LatLng(11.614758, 104.836581));
    Khan_Preaek_Pnov.add(LatLng(11.615249, 104.837205));
    //////////////////////////48
    Khan_Preaek_Pnov.add(LatLng(11.615903, 104.837503));
    Khan_Preaek_Pnov.add(LatLng(11.623243, 104.836257));
    Khan_Preaek_Pnov.add(LatLng(11.623281, 104.836929));
    Khan_Preaek_Pnov.add(LatLng(11.622613, 104.837728));
    //////////////////////////49
    Khan_Preaek_Pnov.add(LatLng(11.622682, 104.838383));
    Khan_Preaek_Pnov.add(LatLng(11.625272, 104.838066));
    Khan_Preaek_Pnov.add(LatLng(11.625125, 104.843773));
    ////
    Khan_Preaek_Pnov.add(LatLng(11.625049, 104.843809));

    //////////////////////////50
    Khan_Preaek_Pnov.add(LatLng(11.635738, 104.841972));
    Khan_Preaek_Pnov.add(LatLng(11.636138, 104.841178));
    Khan_Preaek_Pnov.add(LatLng(11.634375, 104.838327));
    Khan_Preaek_Pnov.add(LatLng(11.634246, 104.837369));
    //////////////////////////51

    Khan_Preaek_Pnov.add(LatLng(11.635161, 104.83561));
    Khan_Preaek_Pnov.add(LatLng(11.658057, 104.867383));

    List<LatLng> Khan_Russey_Keo = <LatLng>[];
//////////////////////////////////////////1
    Khan_Russey_Keo.add(LatLng(11.657242, 104.866782));
    Khan_Russey_Keo.add(LatLng(11.649813, 104.856219));
    Khan_Russey_Keo.add(LatLng(11.648721, 104.857060));
    Khan_Russey_Keo.add(LatLng(11.648308, 104.857877));
    Khan_Russey_Keo.add(LatLng(11.648521, 104.861220));
    Khan_Russey_Keo.add(LatLng(11.643447, 104.863401));
//////////////////////////////////////////2
    Khan_Russey_Keo.add(LatLng(11.643131, 104.865789));
    Khan_Russey_Keo.add(LatLng(11.643161, 104.867921));
    Khan_Russey_Keo.add(LatLng(11.642945, 104.868536));
    Khan_Russey_Keo.add(LatLng(11.643145, 104.868955));
    Khan_Russey_Keo.add(LatLng(11.642971, 104.869059));
    Khan_Russey_Keo.add(LatLng(11.642697, 104.869311));
//////////////////////////////////////////3

    Khan_Russey_Keo.add(LatLng(11.642367, 104.870013));
    Khan_Russey_Keo.add(LatLng(11.640606, 104.871784));
    Khan_Russey_Keo.add(LatLng(11.638770, 104.872922));
    Khan_Russey_Keo.add(LatLng(11.636504, 104.873969));
    Khan_Russey_Keo.add(LatLng(11.634699, 104.874455));
    Khan_Russey_Keo.add(LatLng(11.632588, 104.874015));
//////////////////////////////////////////4

    Khan_Russey_Keo.add(LatLng(11.629765, 104.871890));
    Khan_Russey_Keo.add(LatLng(11.627379, 104.871648));
    Khan_Russey_Keo.add(LatLng(11.624296, 104.872126));
    Khan_Russey_Keo.add(LatLng(11.623709, 104.872998));
    Khan_Russey_Keo.add(LatLng(11.624511, 104.875046));
    Khan_Russey_Keo.add(LatLng(11.624504, 104.875608));
//////////////////////////////////////////5ssssssssssssssss

    Khan_Russey_Keo.add(LatLng(11.624501, 104.875922));
    Khan_Russey_Keo.add(LatLng(11.624451, 104.877340));
    Khan_Russey_Keo.add(LatLng(11.622580, 104.877930));
    Khan_Russey_Keo.add(LatLng(11.621065, 104.878091));
    Khan_Russey_Keo.add(LatLng(11.620946, 104.878187));
    Khan_Russey_Keo.add(LatLng(11.620447, 104.878966));
//////////////////////////////////////////6

    Khan_Russey_Keo.add(LatLng(11.619653, 104.879214));
    Khan_Russey_Keo.add(LatLng(11.617004, 104.881256));
    Khan_Russey_Keo.add(LatLng(11.615467, 104.882104));
    Khan_Russey_Keo.add(LatLng(11.614685, 104.882359));
    Khan_Russey_Keo.add(LatLng(11.613967, 104.883597));
    Khan_Russey_Keo.add(LatLng(11.612530, 104.885122));

//////////////////////////////////////////7
    Khan_Russey_Keo.add(LatLng(11.611036, 104.885702));
    Khan_Russey_Keo.add(LatLng(11.609149, 104.885753));
    Khan_Russey_Keo.add(LatLng(11.607624, 104.885658));
    Khan_Russey_Keo.add(LatLng(11.590327, 104.896356));
    Khan_Russey_Keo.add(LatLng(11.590877, 104.897619));
    Khan_Russey_Keo.add(LatLng(11.585747, 104.900796));

//////////////////////////////////////////8
    Khan_Russey_Keo.add(LatLng(11.583288, 104.907941));
    Khan_Russey_Keo.add(LatLng(11.584486, 104.911503));
    Khan_Russey_Keo.add(LatLng(11.585012, 104.914507));
    Khan_Russey_Keo.add(LatLng(11.587849, 104.914550));
    Khan_Russey_Keo.add(LatLng(11.588186, 104.915945));
    Khan_Russey_Keo.add(LatLng(11.588627, 104.918177));
//////////////////////////////////////////9

    Khan_Russey_Keo.add(LatLng(11.588690, 104.919722));
    Khan_Russey_Keo.add(LatLng(11.593062, 104.919121));
    Khan_Russey_Keo.add(LatLng(11.595648, 104.919035));
    Khan_Russey_Keo.add(LatLng(11.600272, 104.919250));
    Khan_Russey_Keo.add(LatLng(11.604392, 104.919292));
    Khan_Russey_Keo.add(LatLng(11.608806, 104.919228));
//////////////////////////////////////////10

    Khan_Russey_Keo.add(LatLng(11.611875, 104.918777));
    Khan_Russey_Keo.add(LatLng(11.615658, 104.917597));
    Khan_Russey_Keo.add(LatLng(11.618243, 104.916589));
    Khan_Russey_Keo.add(LatLng(11.618558, 104.916245));
    Khan_Russey_Keo.add(LatLng(11.618821, 104.916235));
    Khan_Russey_Keo.add(LatLng(11.621711, 104.914078));
//////////////////////////////////////////11
    Khan_Russey_Keo.add(LatLng(11.623298, 104.912694));
    Khan_Russey_Keo.add(LatLng(11.626608, 104.909722));
    Khan_Russey_Keo.add(LatLng(11.629708, 104.906718));
    Khan_Russey_Keo.add(LatLng(11.631295, 104.904862));
    Khan_Russey_Keo.add(LatLng(11.633386, 104.901858));
    Khan_Russey_Keo.add(LatLng(11.634689, 104.899369));
//////////////////////////////////////////12

    Khan_Russey_Keo.add(LatLng(11.635898, 104.896247));
    Khan_Russey_Keo.add(LatLng(11.636917, 104.893254));
    Khan_Russey_Keo.add(LatLng(11.639059, 104.886843));
    Khan_Russey_Keo.add(LatLng(11.639973, 104.884332));
    Khan_Russey_Keo.add(LatLng(11.641255, 104.881339));
    Khan_Russey_Keo.add(LatLng(11.642884, 104.878764));
//////////////////////////////////////////13

    Khan_Russey_Keo.add(LatLng(11.645896, 104.875229));
    Khan_Russey_Keo.add(LatLng(11.649069, 104.872472));
    Khan_Russey_Keo.add(LatLng(11.655037, 104.868084));
    Khan_Russey_Keo.add(LatLng(11.657286, 104.866872));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));

    //   Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));

    //   Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));
    // Khan_Russey_Keo.add(LatLng(11.560825, 104.721297));

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
        fillColor: Color.fromARGB(123, 93, 78, 175),
        strokeWidth: 1,
        strokeColor: Color.fromARGB(143, 140, 0, 255),
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
