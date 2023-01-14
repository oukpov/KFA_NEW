// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_field, prefer_is_empty, prefer_if_null_operators

import 'dart:convert';
import 'package:admin/Customs/ProgressHUD.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandBuildingDetail extends StatefulWidget {
  final String id;
  const LandBuildingDetail({
    super.key,
    required this.id,
  });

  @override
  State<LandBuildingDetail> createState() => _LandBuildingDetailState();
}

class _LandBuildingDetailState extends State<LandBuildingDetail> {
  final _formKey = GlobalKey<FormState>();
  List data_of_land = [];

  bool isApiCallProcess = false;
  // late int asking_price;

  @override
  void initState() {
    super.initState();
    Get_land();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ProgressHUD(
        color: kPrimaryColor,
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: _uiSteup(context),
      ),
    );
  }

  Widget _uiSteup(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Land/Building",
                style: TextStyle(color: kImageColor, fontSize: 20),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 22, right: 22),
          width: double.infinity,
          height: 270,
          child: data_of_land.length > 0
              ? ListView.builder(
                  itemCount: data_of_land.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        width: 260,
                        //height: 210,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: data_of_land[index]
                                              ["verbal_land_type"] !=
                                          null
                                      ? Text(
                                          data_of_land[index]
                                              ["verbal_land_type"],
                                          style: NameProperty(),
                                        )
                                      : Text(
                                          "N/A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: kImageColor),
                                        ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Text.rich(
                                TextSpan(
                                  children: <InlineSpan>[
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.location_on_sharp,
                                      color: kPrimaryColor,
                                      size: 14,
                                    )),
                                    TextSpan(
                                        text: data_of_land[index]["address"] !=
                                                null
                                            ? data_of_land[index]["address"]
                                            : "N/A"),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12, color: kPrimaryColor),
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: data_of_land[index]["verbal_land_des"] !=
                                      null
                                  ? Text(
                                      data_of_land[index]["verbal_land_des"],
                                    )
                                  : Text(
                                      "N/A",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: kImageColor,
                                      ),
                                    ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Depreciation",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Area",
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value/Sqm',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Max Value/Sqm',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value',
                                      style: Label(),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Min Value',
                                      style: Label(),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    data_of_land[index]["verbal_land_dp"] !=
                                            null
                                        ? Text(
                                            ':   ' +
                                                data_of_land[index]
                                                    ["verbal_land_dp"],
                                            style: Name(),
                                          )
                                        : Text(
                                            "N/A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: kImageColor),
                                          ),
                                    SizedBox(height: 2),
                                    data_of_land[index]["verbal_land_area"] !=
                                            null
                                        ? Text(
                                            ':   ' +
                                                data_of_land[index]
                                                        ["verbal_land_area"]
                                                    .toString() +
                                                'm' +
                                                '\u00B2',
                                            style: Name(),
                                          )
                                        : Text(
                                            "N/A",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: kImageColor,
                                            ),
                                          ),
                                    SizedBox(height: 2),
                                    data_of_land[index]["verbal_land_minsqm"] !=
                                            null
                                        ? Text(
                                            ':   ' +
                                                (data_of_land[index]
                                                        ["verbal_land_minsqm"])
                                                    .toString() +
                                                '\$',
                                            style: Name(),
                                          )
                                        : Text(
                                            "N/A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: kImageColor),
                                          ),
                                    SizedBox(height: 2),
                                    data_of_land[index]["verbal_land_maxsqm"] !=
                                            null
                                        ? Text(
                                            ':   ' +
                                                (data_of_land[index]
                                                        ["verbal_land_maxsqm"])
                                                    .toString() +
                                                '\$',
                                            style: Name(),
                                          )
                                        : Text(
                                            "N/A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: kImageColor),
                                          ),
                                    SizedBox(height: 2),
                                    data_of_land[index]
                                                ["verbal_land_minvalue"] !=
                                            null
                                        ? Text(
                                            ':   ' +
                                                (data_of_land[index][
                                                        "verbal_land_minvalue"])
                                                    .toString() +
                                                '\$',
                                            style: Name(),
                                          )
                                        : Text(
                                            "N/A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: kPrimaryColor),
                                          ),
                                    SizedBox(height: 2),
                                    data_of_land[index]
                                                ["verbal_land_maxvalue"] !=
                                            null
                                        ? Text(
                                            ':   ' +
                                                (data_of_land[index][
                                                            "verbal_land_maxvalue"]
                                                        .toString() +
                                                    '\$'),
                                            style: Name(),
                                          )
                                        : Text(
                                            "N/A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: kImageColor),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  // separatorBuilder: (BuildContext context, int index) =>
                  //     const Divider(),
                )
              : const Center(child: Text('No items')),
        ),
      ],
    );
  }

  void Get_land() async {
    setState(() {});
    var id = widget.id;
    //print(id);
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$id'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        data_of_land = jsonData;
      });
    }
  }

  TextStyle Label() {
    return TextStyle(color: kPrimaryColor, fontSize: 13);
  }

  TextStyle Name() {
    return TextStyle(
        color: kImageColor, fontSize: 14, fontWeight: FontWeight.bold);
  }

  TextStyle NameProperty() {
    return TextStyle(
        color: kImageColor, fontSize: 15, fontWeight: FontWeight.bold);
  }
}
