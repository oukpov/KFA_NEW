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
    Khan_Preaek_Pnov.add(LatLng(11.658289, 104.867638));
    Khan_Preaek_Pnov.add(LatLng(11.684094, 104.851412));
    Khan_Preaek_Pnov.add(LatLng(11.704518, 104.842485));
    Khan_Preaek_Pnov.add(LatLng(11.712943, 104.840888));
    Khan_Preaek_Pnov.add(LatLng(11.713427, 104.838484));
    Khan_Preaek_Pnov.add(LatLng(11.713112, 104.837374));
    Khan_Preaek_Pnov.add(LatLng(11.712092, 104.836687));
    Khan_Preaek_Pnov.add(LatLng(11.712061, 104.836642));
    Khan_Preaek_Pnov.add(LatLng(11.711205, 104.835596));
    Khan_Preaek_Pnov.add(LatLng(11.711294, 104.83471));
    Khan_Preaek_Pnov.add(LatLng(11.712087, 104.833648));
    Khan_Preaek_Pnov.add(LatLng(11.714482, 104.832919));
    Khan_Preaek_Pnov.add(LatLng(11.715339, 104.831245));
    Khan_Preaek_Pnov.add(LatLng(11.716662, 104.830872));
    Khan_Preaek_Pnov.add(LatLng(11.717891, 104.8301));
    Khan_Preaek_Pnov.add(LatLng(11.718165, 104.828748));
    Khan_Preaek_Pnov.add(LatLng(11.718007, 104.826441));
    Khan_Preaek_Pnov.add(LatLng(11.715769, 104.824488));
    Khan_Preaek_Pnov.add(LatLng(11.715118, 104.822536));
    Khan_Preaek_Pnov.add(LatLng(11.713511, 104.821347));
    Khan_Preaek_Pnov.add(LatLng(11.713088, 104.822296));
    Khan_Preaek_Pnov.add(LatLng(11.711877, 104.823294));
    Khan_Preaek_Pnov.add(LatLng(11.710081, 104.824084));
    Khan_Preaek_Pnov.add(LatLng(11.708699, 104.824186));
    Khan_Preaek_Pnov.add(LatLng(11.707898, 104.823149));
    Khan_Preaek_Pnov.add(LatLng(11.708815, 104.822095));
    Khan_Preaek_Pnov.add(LatLng(11.708295, 104.820311));
    Khan_Preaek_Pnov.add(LatLng(11.708762, 104.819286));
    Khan_Preaek_Pnov.add(LatLng(11.708442, 104.818211));
    Khan_Preaek_Pnov.add(LatLng(11.706892, 104.817658));
    Khan_Preaek_Pnov.add(LatLng(11.705658, 104.816242));
    Khan_Preaek_Pnov.add(LatLng(11.703788, 104.815291));
    Khan_Preaek_Pnov.add(LatLng(11.701545, 104.815411));
    Khan_Preaek_Pnov.add(LatLng(11.699617, 104.815871));
    Khan_Preaek_Pnov.add(LatLng(11.697952, 104.815265));
    Khan_Preaek_Pnov.add(LatLng(11.696407, 104.815118));
    Khan_Preaek_Pnov.add(LatLng(11.694117, 104.814795));
    Khan_Preaek_Pnov.add(LatLng(11.691385, 104.814554));
    Khan_Preaek_Pnov.add(LatLng(11.690151, 104.815936));
    Khan_Preaek_Pnov.add(LatLng(11.689308, 104.817076));
    Khan_Preaek_Pnov.add(LatLng(11.688304, 104.816961));
    Khan_Preaek_Pnov.add(LatLng(11.686132, 104.815197));
    Khan_Preaek_Pnov.add(LatLng(11.683821, 104.812944));
    Khan_Preaek_Pnov.add(LatLng(11.681488, 104.811195));
    Khan_Preaek_Pnov.add(LatLng(11.678547, 104.80994));
    Khan_Preaek_Pnov.add(LatLng(11.677125, 104.810159));
    Khan_Preaek_Pnov.add(LatLng(11.675626, 104.811226));
    Khan_Preaek_Pnov.add(LatLng(11.674312, 104.812953));
    Khan_Preaek_Pnov.add(LatLng(11.673926, 104.813686));
    Khan_Preaek_Pnov.add(LatLng(11.673209, 104.812051));
    Khan_Preaek_Pnov.add(LatLng(11.673093, 104.806399));
    Khan_Preaek_Pnov.add(LatLng(11.672618, 104.800538));
    Khan_Preaek_Pnov.add(LatLng(11.671833, 104.798951));
    Khan_Preaek_Pnov.add(LatLng(11.671507, 104.797052));
    Khan_Preaek_Pnov.add(LatLng(11.672392, 104.794243));
    Khan_Preaek_Pnov.add(LatLng(11.672101, 104.789016));
    Khan_Preaek_Pnov.add(LatLng(11.671475, 104.784695));
    Khan_Preaek_Pnov.add(LatLng(11.671339, 104.780221));
    Khan_Preaek_Pnov.add(LatLng(11.669132, 104.780061));
    Khan_Preaek_Pnov.add(LatLng(11.667938, 104.769954));
    Khan_Preaek_Pnov.add(LatLng(11.667965, 104.769652));
    Khan_Preaek_Pnov.add(LatLng(11.667257, 104.766399));
    Khan_Preaek_Pnov.add(LatLng(11.666062, 104.753212));
    Khan_Preaek_Pnov.add(LatLng(11.666062, 104.752721));
    Khan_Preaek_Pnov.add(LatLng(11.662363, 104.749973));
    Khan_Preaek_Pnov.add(LatLng(11.659874, 104.747318));
    Khan_Preaek_Pnov.add(LatLng(11.658981, 104.747039));
    Khan_Preaek_Pnov.add(LatLng(11.657983, 104.747146));
    Khan_Preaek_Pnov.add(LatLng(11.657289, 104.747307));
    Khan_Preaek_Pnov.add(LatLng(11.655619, 104.747468));
    Khan_Preaek_Pnov.add(LatLng(11.654043, 104.747768));
    Khan_Preaek_Pnov.add(LatLng(11.651983, 104.747811));
    Khan_Preaek_Pnov.add(LatLng(11.649071, 104.746155));
    Khan_Preaek_Pnov.add(LatLng(11.646908, 104.745322));
    Khan_Preaek_Pnov.add(LatLng(11.645531, 104.744163));
    Khan_Preaek_Pnov.add(LatLng(11.643646, 104.744407));
    Khan_Preaek_Pnov.add(LatLng(11.641611, 104.744528));
    Khan_Preaek_Pnov.add(LatLng(11.639341, 104.744496));
    Khan_Preaek_Pnov.add(LatLng(11.635013, 104.744616));
    Khan_Preaek_Pnov.add(LatLng(11.629493, 104.741841));
    Khan_Preaek_Pnov.add(LatLng(11.625722, 104.74088));
    Khan_Preaek_Pnov.add(LatLng(11.623541, 104.740543));
    Khan_Preaek_Pnov.add(LatLng(11.622103, 104.739969));
    Khan_Preaek_Pnov.add(LatLng(11.619469, 104.739207));
    Khan_Preaek_Pnov.add(LatLng(11.606827, 104.734421));
    Khan_Preaek_Pnov.add(LatLng(11.603043, 104.734647));
    Khan_Preaek_Pnov.add(LatLng(11.601557, 104.735384));
    Khan_Preaek_Pnov.add(LatLng(11.600353, 104.735731));
    Khan_Preaek_Pnov.add(LatLng(11.596407, 104.733941));
    Khan_Preaek_Pnov.add(LatLng(11.591899, 104.731597));
    Khan_Preaek_Pnov.add(LatLng(11.590301, 104.731561));
    Khan_Preaek_Pnov.add(LatLng(11.587629, 104.732357));
    Khan_Preaek_Pnov.add(LatLng(11.586427, 104.732812));
    Khan_Preaek_Pnov.add(LatLng(11.585591, 104.733352));
    Khan_Preaek_Pnov.add(LatLng(11.585841, 104.734316));
    Khan_Preaek_Pnov.add(LatLng(11.588107, 104.734552));
    Khan_Preaek_Pnov.add(LatLng(11.588699, 104.735278));
    Khan_Preaek_Pnov.add(LatLng(11.589222, 104.736746));
    Khan_Preaek_Pnov.add(LatLng(11.589204, 104.739205));
    Khan_Preaek_Pnov.add(LatLng(11.589897, 104.739844));
    Khan_Preaek_Pnov.add(LatLng(11.590208, 104.740696));
    Khan_Preaek_Pnov.add(LatLng(11.589246, 104.742064));
    Khan_Preaek_Pnov.add(LatLng(11.589834, 104.745423));
    Khan_Preaek_Pnov.add(LatLng(11.590428, 104.746275));
    Khan_Preaek_Pnov.add(LatLng(11.589966, 104.747075));
    Khan_Preaek_Pnov.add(LatLng(11.589792, 104.748086));
    Khan_Preaek_Pnov.add(LatLng(11.589966, 104.749719));
    Khan_Preaek_Pnov.add(LatLng(11.590843, 104.75031));
    Khan_Preaek_Pnov.add(LatLng(11.590927, 104.750709));
    Khan_Preaek_Pnov.add(LatLng(11.590765, 104.751348));
    Khan_Preaek_Pnov.add(LatLng(11.590129, 104.751747));
    Khan_Preaek_Pnov.add(LatLng(11.589467, 104.752715));
    Khan_Preaek_Pnov.add(LatLng(11.589929, 104.756028));
    Khan_Preaek_Pnov.add(LatLng(11.589858, 104.757205));
    Khan_Preaek_Pnov.add(LatLng(11.590355, 104.758089));
    Khan_Preaek_Pnov.add(LatLng(11.590539, 104.759469));
    Khan_Preaek_Pnov.add(LatLng(11.591911, 104.760627));
    Khan_Preaek_Pnov.add(LatLng(11.592017, 104.761304));
    Khan_Preaek_Pnov.add(LatLng(11.592039, 104.762833));
    Khan_Preaek_Pnov.add(LatLng(11.592725, 104.765491));
    Khan_Preaek_Pnov.add(LatLng(11.592677, 104.766145));
    Khan_Preaek_Pnov.add(LatLng(11.592922, 104.768327));
    Khan_Preaek_Pnov.add(LatLng(11.593393, 104.770489));
    Khan_Preaek_Pnov.add(LatLng(11.593849, 104.771831));
    Khan_Preaek_Pnov.add(LatLng(11.595016, 104.772684));
    Khan_Preaek_Pnov.add(LatLng(11.595557, 104.773677));
    Khan_Preaek_Pnov.add(LatLng(11.597018, 104.774584));
    Khan_Preaek_Pnov.add(LatLng(11.598474, 104.775978));
    Khan_Preaek_Pnov.add(LatLng(11.598437, 104.777534));
    Khan_Preaek_Pnov.add(LatLng(11.599325, 104.778253));
    Khan_Preaek_Pnov.add(LatLng(11.602567, 104.778239));
    Khan_Preaek_Pnov.add(LatLng(11.605158, 104.779808));
    Khan_Preaek_Pnov.add(LatLng(11.605473, 104.780302));
    Khan_Preaek_Pnov.add(LatLng(11.605315, 104.781825));
    Khan_Preaek_Pnov.add(LatLng(11.605893, 104.782341));
    Khan_Preaek_Pnov.add(LatLng(11.606293, 104.783306));
    Khan_Preaek_Pnov.add(LatLng(11.606245, 104.784637));
    Khan_Preaek_Pnov.add(LatLng(11.604522, 104.788698));
    Khan_Preaek_Pnov.add(LatLng(11.603886, 104.791525));
    Khan_Preaek_Pnov.add(LatLng(11.600922, 104.797479));
    Khan_Preaek_Pnov.add(LatLng(11.602162, 104.798745));
    Khan_Preaek_Pnov.add(LatLng(11.601815, 104.801631));
    Khan_Preaek_Pnov.add(LatLng(11.599708, 104.801191));
    Khan_Preaek_Pnov.add(LatLng(11.599468, 104.803159));
    Khan_Preaek_Pnov.add(LatLng(11.596626, 104.802546));
    Khan_Preaek_Pnov.add(LatLng(11.591067, 104.80077));
    Khan_Preaek_Pnov.add(LatLng(11.591217, 104.801985));
    Khan_Preaek_Pnov.add(LatLng(11.589556, 104.802763));
    Khan_Preaek_Pnov.add(LatLng(11.587534, 104.802918));
    Khan_Preaek_Pnov.add(LatLng(11.585459, 104.803305));
    Khan_Preaek_Pnov.add(LatLng(11.584621, 104.804177));
    Khan_Preaek_Pnov.add(LatLng(11.584293, 104.807046));
    Khan_Preaek_Pnov.add(LatLng(11.583966, 104.808013));
    Khan_Preaek_Pnov.add(LatLng(11.583189, 104.808779));
    Khan_Preaek_Pnov.add(LatLng(11.582787, 104.810702));
    Khan_Preaek_Pnov.add(LatLng(11.582151, 104.811367));
    Khan_Preaek_Pnov.add(LatLng(11.582083, 104.817852));
    Khan_Preaek_Pnov.add(LatLng(11.578943, 104.818025));
    Khan_Preaek_Pnov.add(LatLng(11.578967, 104.820052));
    Khan_Preaek_Pnov.add(LatLng(11.580704, 104.822772));
    Khan_Preaek_Pnov.add(LatLng(11.581027, 104.824124));
    Khan_Preaek_Pnov.add(LatLng(11.582463, 104.824327));
    Khan_Preaek_Pnov.add(LatLng(11.583172, 104.824792));
    Khan_Preaek_Pnov.add(LatLng(11.584462, 104.824653));
    Khan_Preaek_Pnov.add(LatLng(11.587575, 104.823615));
    Khan_Preaek_Pnov.add(LatLng(11.588171, 104.824972));
    Khan_Preaek_Pnov.add(LatLng(11.588187, 104.826361));
    Khan_Preaek_Pnov.add(LatLng(11.588521, 104.828614));
    Khan_Preaek_Pnov.add(LatLng(11.590066, 104.828847));
    Khan_Preaek_Pnov.add(LatLng(11.589882, 104.830084));
    Khan_Preaek_Pnov.add(LatLng(11.591281, 104.830984));
    Khan_Preaek_Pnov.add(LatLng(11.592446, 104.831157));
    Khan_Preaek_Pnov.add(LatLng(11.593297, 104.83179));
    Khan_Preaek_Pnov.add(LatLng(11.594463, 104.831355));
    Khan_Preaek_Pnov.add(LatLng(11.595394, 104.831328));
    Khan_Preaek_Pnov.add(LatLng(11.599112, 104.832192));
    Khan_Preaek_Pnov.add(LatLng(11.599672, 104.834547));
    Khan_Preaek_Pnov.add(LatLng(11.601871, 104.834389));
    Khan_Preaek_Pnov.add(LatLng(11.603149, 104.835165));
    Khan_Preaek_Pnov.add(LatLng(11.604203, 104.835124));
    Khan_Preaek_Pnov.add(LatLng(11.605105, 104.834665));
    Khan_Preaek_Pnov.add(LatLng(11.608221, 104.834947));
    Khan_Preaek_Pnov.add(LatLng(11.608899, 104.835641));
    Khan_Preaek_Pnov.add(LatLng(11.609036, 104.836414));
    Khan_Preaek_Pnov.add(LatLng(11.609918, 104.836682));
    Khan_Preaek_Pnov.add(LatLng(11.610002, 104.837733));
    Khan_Preaek_Pnov.add(LatLng(11.614758, 104.836581));
    Khan_Preaek_Pnov.add(LatLng(11.615249, 104.837205));
    Khan_Preaek_Pnov.add(LatLng(11.615903, 104.837503));
    Khan_Preaek_Pnov.add(LatLng(11.623243, 104.836257));
    Khan_Preaek_Pnov.add(LatLng(11.623281, 104.836929));
    Khan_Preaek_Pnov.add(LatLng(11.622613, 104.837728));
    Khan_Preaek_Pnov.add(LatLng(11.622682, 104.838383));
    Khan_Preaek_Pnov.add(LatLng(11.625272, 104.838066));
    Khan_Preaek_Pnov.add(LatLng(11.625125, 104.843773));
    Khan_Preaek_Pnov.add(LatLng(11.625049, 104.843809));
    Khan_Preaek_Pnov.add(LatLng(11.635738, 104.841972));
    Khan_Preaek_Pnov.add(LatLng(11.636138, 104.841178));
    Khan_Preaek_Pnov.add(LatLng(11.634375, 104.838327));
    Khan_Preaek_Pnov.add(LatLng(11.634246, 104.837369));
    Khan_Preaek_Pnov.add(LatLng(11.635161, 104.83561));
    Khan_Preaek_Pnov.add(LatLng(11.658057, 104.867383));

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

//1
    Khan_Sen_Sok.add(LatLng(11.649285, 104.856372));
    Khan_Sen_Sok.add(LatLng(11.647940, 104.861179));
    Khan_Sen_Sok.add(LatLng(11.644158, 104.863067));
    Khan_Sen_Sok.add(LatLng(11.642476, 104.869934));
    Khan_Sen_Sok.add(LatLng(11.639702, 104.872423));
    Khan_Sen_Sok.add(LatLng(11.635919, 104.874011));
//2
    Khan_Sen_Sok.add(LatLng(11.630371, 104.872637));
    Khan_Sen_Sok.add(LatLng(11.625747, 104.872852));
    Khan_Sen_Sok.add(LatLng(11.623708, 104.877701));
    Khan_Sen_Sok.add(LatLng(11.620429, 104.878710));
    Khan_Sen_Sok.add(LatLng(11.611812, 104.885297));
    Khan_Sen_Sok.add(LatLng(11.608554, 104.885920));
//3
    Khan_Sen_Sok.add(LatLng(11.598360, 104.891391));
    Khan_Sen_Sok.add(LatLng(11.590772, 104.896884));
    Khan_Sen_Sok.add(LatLng(11.588543, 104.893301));
    Khan_Sen_Sok.add(LatLng(11.585937, 104.891520));
    Khan_Sen_Sok.add(LatLng(11.585454, 104.890554));
    Khan_Sen_Sok.add(LatLng(11.585033, 104.889803));
//4
    Khan_Sen_Sok.add(LatLng(11.584318, 104.888151));
    Khan_Sen_Sok.add(LatLng(11.570684, 104.887694));
    Khan_Sen_Sok.add(LatLng(11.565146, 104.889901));
    Khan_Sen_Sok.add(LatLng(11.561921, 104.891904));
    Khan_Sen_Sok.add(LatLng(11.559321, 104.888307));
    Khan_Sen_Sok.add(LatLng(11.554659, 104.887133));
//5
    Khan_Sen_Sok.add(LatLng(11.550109, 104.890054));
    Khan_Sen_Sok.add(LatLng(11.548721, 104.886916));
    Khan_Sen_Sok.add(LatLng(11.548058, 104.881200));
    Khan_Sen_Sok.add(LatLng(11.547508, 104.877462));
    Khan_Sen_Sok.add(LatLng(11.547321, 104.872371));
    Khan_Sen_Sok.add(LatLng(11.545958, 104.865455));
//6
    Khan_Sen_Sok.add(LatLng(11.545746, 104.863899));
    Khan_Sen_Sok.add(LatLng(11.545533, 104.860735));
    Khan_Sen_Sok.add(LatLng(11.554856, 104.862862));
    Khan_Sen_Sok.add(LatLng(11.560781, 104.862875));
    Khan_Sen_Sok.add(LatLng(11.567693, 104.863666));
    Khan_Sen_Sok.add(LatLng(11.566268, 104.850486));
//7
    Khan_Sen_Sok.add(LatLng(11.567693, 104.834512));
    Khan_Sen_Sok.add(LatLng(11.568843, 104.830480));
    Khan_Sen_Sok.add(LatLng(11.569343, 104.824509));
    Khan_Sen_Sok.add(LatLng(11.579868, 104.823769));
    Khan_Sen_Sok.add(LatLng(11.586042, 104.830021));
    Khan_Sen_Sok.add(LatLng(11.588692, 104.831424));
//8
    Khan_Sen_Sok.add(LatLng(11.592167, 104.832521));
    Khan_Sen_Sok.add(LatLng(11.595916, 104.833185));
    Khan_Sen_Sok.add(LatLng(11.601115, 104.832419));
    Khan_Sen_Sok.add(LatLng(11.605715, 104.832853));
    Khan_Sen_Sok.add(LatLng(11.609614, 104.832828));
    Khan_Sen_Sok.add(LatLng(11.613338, 104.833466));
//9
    Khan_Sen_Sok.add(LatLng(11.618287, 104.835430));
    Khan_Sen_Sok.add(LatLng(11.620137, 104.838250));
    Khan_Sen_Sok.add(LatLng(11.634858, 104.836234));

    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));

    //   Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));
    //  Khan_Sen_Sok.add(LatLng(11.560825, 104.721297));


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

//
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
        fillColor: Color.fromARGB(149, 49, 85, 184),
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
