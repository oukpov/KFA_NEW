// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_import, unused_field, unnecessary_new, prefer_collection_literals, prefer_final_fields, unused_element, sized_box_for_whitespace, sort_child_properties_last, avoid_print, unnecessary_brace_in_string_interps

/*
Name: Akshath Jain
Date: 3/18/2019 - 4/26/2021
Purpose: Example app that implements the package: sliding_up_panel
Copyright: © 2021, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:admin/Customs/ProgressHUD.dart';
import 'package:admin/model/models/search_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:location_geocoder/location_geocoder.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ToFromDate.dart';
import 'contants.dart';
import 'distance.dart';
import 'landsize.dart';
import 'numDisplay.dart';
import 'road.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelExample extends StatelessWidget {
  const SlidingUpPanelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
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
  double adding_price = 0.0;
  String sendAddrress = '';
  List data = [];
  var date = DateFormat('yyyy-MM-dd').format(DateTime(2020, 01, 01));
  var date1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isApiCallProcess = false;
  // static const apiKey = "AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY";
  late LocatitonGeocoder geocoder = LocatitonGeocoder(googleApikey);
  late SearchRequestModel requestModel;
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
  dynamic lat, log;
  final Set<Marker> marker = new Set();
  int num = 0;

  @override
  void initState() {
    _getCurrentPosition();
    getAddress(latLng);

    requestModel = new SearchRequestModel(
      property_type_id: "",
      num: "5",
      lat: "",
      lng: "",
      land_min: "0",
      land_max: "10000000",
      distance: "50000",
      fromDate: "$date",
      toDate: "$date1",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    index = _selectedIndex;
    setState(() {
      if (_selectedIndex == 0) {
        num = 0;
      } else {
        if (index < 1) {
          index = index + 1;
        } else {
          index = 0;
        }
      }
    });
  }

  Widget _uiSteup(BuildContext context) {
    // TextEditingController search = TextEditingController();
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("GoogleMap")),
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            color: kwhite,
            //style: IconButton.styleFrom(backgroundColor: kImageColor),
            //onPressed: () => Show(),S
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Add(
              //       asking_price: adding_price,
              //     ),
              //   ),
              // );

              data = [
                {
                  'adding_price': adding_price,
                  'address': sendAddrress,
                  'lat': requestModel.lat,
                  'lng': requestModel.lng
                }
              ];
              Navigator.pop(context, data);
            },
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: Container(
        child: MapShow(),
        height: MediaQuery.of(context).size.height * 1,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        color: Colors.blue[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon:
                  Icon(Icons.person_pin_circle, size: 40, color: Colors.black),
              onPressed: () {
                setState(() {
                  num = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.business, size: 40, color: Colors.black),
              onPressed: () {
                setState(() {
                  if (index < 1) {
                    index = index + 1;
                  } else {
                    index = 0;
                  }
                });
              },
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: circularMenu,
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      marker.add(Marker(
        //add second marker
        markerId: MarkerId("showLocation.toString()"),
        position: LatLng(lat, log), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Thanks for using us',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      requestModel.lat = lat.toString();
      requestModel.lng = log.toString();
      //add more markers here
    });

    return marker;
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "More Option",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 36.0),
          // RoadDropdown(
          //   onChanged: (value) {
          //     // requestModel.comparable_road = value;
          //     //  print(requestModel.comparable_road);
          //   },
          // ),
          // SizedBox(height: 10.0),
          ToFromDate(
            fromDate: (value) {
              requestModel.fromDate = value;
              print(requestModel.fromDate);
            },
            toDate: (value) {
              requestModel.toDate = value;
              // print(requestModel.toDate);
            },
          ),
          SizedBox(height: 10.0),
          LandSize(
            land_min: (value) {
              requestModel.land_min = value;
              print(requestModel.fromDate);
            },
            land_max: (value) {
              requestModel.land_max = value;
              print(requestModel.toDate);
            },
          ),
          SizedBox(height: 10.0),
          NumDisplay(onSaved: (newValue) => requestModel.num = newValue!),
          SizedBox(height: 10.0),
          Distance(onSaved: (input) => requestModel.distance = input!),
          addPaddingWhenKeyboardAppears(),
        ],
      ),
    );
  }

  SizedBox addPaddingWhenKeyboardAppears() {
    final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio,
    );

    final bottomOffset = viewInsets.bottom;
    const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
    final isNeedPadding = bottomOffset != hiddenKeyboard;

    return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
  }

  List<MapType> style_map = [
    MapType.hybrid,
    MapType.normal,
  ];
  int index = 0;
  Stack MapShow() {
    return Stack(
      children: [
        (lat != null)
            ? GoogleMap(
                // markers: getmarkers(),
                markers:
                    ((num > 0) ? Set<Marker>.of(markers.values) : getmarkers()),
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: LatLng(latitude, longitude), //initial position
                  zoom: 10.0, //initial zoom level
                ),
                mapType: style_map[index], //map type
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
                    num = num + 1;
                    markers[markerId] = marker;
                    requestModel.lat = argument.latitude.toString();
                    requestModel.lng = argument.longitude.toString();
                    getAddress(argument);
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona; //when map is dragging
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        Align(
          alignment: Alignment.topCenter,
          child: SearchLocation(
            apiKey:
                'AIzaSyCeogkN2j3bqrqyIuv4GD4bT1n_4lpNlnY', // YOUR GOOGLE MAPS API KEY
            country: 'KH',
            onSelected: (Place place) {
              address = place.description;
              print(place.description);
              getLatLang(address);
            },
          ),
        ),
      ],
    );
  }

  void Load() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/comparable/list?page=100'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData['data'];
      });

      // print(list.length);
    }
  }

  void Clear() {
    setState(() {
      for (var i = 0; i < list.length; i++) {
        MarkerId markerId = MarkerId('$i');
        listMarkerIds.remove(markerId);
      }
    });
  }

  Future<void> Show(SearchRequestModel requestModel) async {
    setState(() {
      isApiCallProcess = true;
    });
    final rs = await http.post(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/map/map_action'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: requestModel.toJson());
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        list = jsonData['autoverbal'];
      });
    }
    Map map = list.asMap();
    if (requestModel.lat.isEmpty || requestModel.lng.isEmpty) {
      setState(() {
        isApiCallProcess = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Please tap on map to select location',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else {
      setState(() {
        isApiCallProcess = false;
      });
      if (map.isEmpty) {
        markers.clear();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'No data found!',
          desc: "You can try to change the information. ",
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      } else {
        adding_price = 0;
        for (var i = 0; i < map.length; i++) {
          print("Index $i");
          if (map[i]['comparable_adding_price'] == '') {
            map[i]['comparable_adding_price'] = '0';
            adding_price +=
                double.parse(map[i]['comparable_adding_price']) / map.length;
            print(map[i]['comparable_adding_price']);
          } else if (map[i]['comparable_adding_price'].contains(',')) {
            print(map[i]['comparable_adding_price'].replaceAll(",", ""));
            adding_price += double.parse(
                    map[i]['comparable_adding_price'].replaceAll(",", "")) /
                map.length;
            print(map[i]['comparable_adding_price']);
            //print(map[i]['comparable_adding_price'].split(",")[0]);
          } else {
            adding_price +=
                (double.parse(map[i]['comparable_adding_price'])) / map.length;
            print(map[i]['comparable_adding_price']);
          }
          MarkerId markerId = MarkerId('$i');
          listMarkerIds.add(markerId);
          Marker marker = Marker(
            markerId: markerId,
            position: LatLng(
              double.parse(map[i]['latlong_log']),
              double.parse(map[i]['latlong_la']),
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            onTap: () {
              setState(() {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title: Text(
                      map[i]['property_type_name'],
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    content: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                    color: kImageColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Land-Width'),
                              Text('Land-Length'),
                              Text('Land-Total'),
                              Text('Date'),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '  :   ' +
                                    map[i]['comparable_adding_price'] +
                                    '\$',
                                style: TextStyle(
                                    color: kImageColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('  :   ' + map[i]['comparable_land_width']),
                              Text('  :   ' + map[i]['comparable_land_length']),
                              Text('  :   ' + map[i]['comparable_land_total']),
                              Text('  :   ' + map[i]['comparable_survey_date']),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              });
            },
          );
          setState(() {
            isApiCallProcess = false;
            markers[markerId] = marker;
          });
        }
        print(adding_price);
      }
    }
  }

  ///converts `coordinates` to actual `address` using google map api
  Future<void> getAddress(LatLng latLng) async {
    final coordinates = Coordinates(latLng.latitude, latLng.longitude);
    try {
      final address = await geocoder.findAddressesFromCoordinates(coordinates);
      var message = address.first.addressLine;
      if (message == null) return;
      sendAddrress = message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Address: ${message}"),
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

  // bool _isShowDial = false;
  // Widget _getFloatingActionButton() {
  //   return SpeedDialMenuButton(
  //     //if needed to close the menu after clicking sub-FAB
  //     isShowSpeedDial: _isShowDial,
  //     //manually open or close menu
  //     updateSpeedDialStatus: (isShow) {
  //       //return any open or close change within the widget
  //       this._isShowDial = isShow;
  //     },
  //     //general init
  //     isMainFABMini: false,
  //     mainMenuFloatingActionButton: MainMenuFloatingActionButton(
  //         mini: false,
  //         child: Icon(Icons.menu),
  //         onPressed: () {},
  //         closeMenuChild: Icon(Icons.close),
  //         closeMenuForegroundColor: Colors.white,
  //         closeMenuBackgroundColor: Colors.red),
  //     floatingActionButtonWidgetChildren: <FloatingActionButton>[
  //       FloatingActionButton(
  //         mini: true,
  //         child: Icon(Icons.location_history),
  //         onPressed: () {
  //           //if need to close menu after click
  //           _isShowDial = false;
  //           setState(() {
  //             num = 0;
  //           });
  //         },
  //         backgroundColor: Colors.pink,
  //       ),
  //       FloatingActionButton(
  //         mini: true,
  //         child: Icon(Icons.photo_size_select_large),
  //         onPressed: () {
  //           //if need to toggle menu after click
  //           _isShowDial = !_isShowDial;
  //           setState(() {
  //             if (index < 1) {
  //               index = index + 1;
  //             } else {
  //               index = 0;
  //             }
  //           });
  //         },
  //         backgroundColor: Colors.orange,
  //       ),
  //     ],
  //     isSpeedDialFABsMini: true,
  //     paddingBtwSpeedDialButton: 80.0,
  //   );
  // }

  // Widget _getBodyWidget() {
  //   return Container();
  // }

}
