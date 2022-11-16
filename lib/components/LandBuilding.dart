// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:admin/Customs/Contants.dart';
import 'package:admin/Customs/ProgressHUD.dart';
import 'package:admin/Customs/formVLDN.dart';
import 'package:admin/Customs/formnum.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../customs/form.dart';
import 'autoVerbalType.dart';

class LandBuilding extends StatefulWidget {
  final double asking_price;
  final String address;
  final int opt;
  const LandBuilding(
      {super.key,
      required this.asking_price,
      required this.opt,
      required this.address});

  @override
  State<LandBuilding> createState() => _LandBuildingState();
}

class _LandBuildingState extends State<LandBuilding> {
  final _formKey = GlobalKey<FormState>();
  List list = [];
  late int min = 0;
  late int max = 0;
  late String des;
  late String dep;
  late double area;
  late String autoverbalType;
  late String autoverbalTypeValue = '';
  late double minSqm, maxSqm, totalMin = 0, totalMax = 0;
  bool isApiCallProcess = false;
  // late int asking_price;
  void addItemToList() {
    print(widget.asking_price);
    setState(() {
      list.add({
        "Property": autoverbalType,
        "Description": des,
        "Depreciation": dep,
        "Area": area,
        "minSqm": minSqm.toStringAsFixed(0),
        "maxSqm": maxSqm.toStringAsFixed(0),
        "totalMin": totalMin.toStringAsFixed(0),
        "totalMax": totalMax.toStringAsFixed(0),
        "address": widget.address
      });
      minSqm = 0;
      maxSqm = 0;
      totalMax = 0;
      totalMin = 0;
      area = 0;
    });
    //  print(id);
  }

  void deleteItemToList(int Id) {
    print(Id);
    setState(() {
      list.removeAt(Id);
    });
  }

  @override
  void initState() {
    minSqm = 0;
    maxSqm = 0;
    //  asking_price = 1;
    super.initState();
    // ignore: unnecessary_new
    des = "";
    dep = "";
    area = 0;
    autoverbalType = "";
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
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 400,
                                      child: AutoVerbalTypeDropdown(
                                        name: (value) {
                                          autoverbalType = value;
                                        },
                                        id: (value) {
                                          autoverbalTypeValue = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 400,
                                      child: FormS(
                                        label: "Desciption",
                                        iconname: Icon(
                                          Icons.book,
                                          color: kImageColor,
                                        ),
                                        onSaved: (newValue) => des = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 400,
                                      child: FormN(
                                        label: "Depreciation",
                                        iconname: Icon(
                                          Icons.monetization_on,
                                          color: kImageColor,
                                        ),
                                        onSaved: (newValue) => dep = newValue!,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 400,
                                      child: FormValidateN(
                                        label: "Area",
                                        iconname: Icon(
                                          Icons.layers,
                                          color: kImageColor,
                                        ),
                                        onSaved: (newValue) =>
                                            area = double.parse(newValue!),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                        child: Text("Save"),
                                        onPressed: () {
                                          if (widget.asking_price == 1.0) {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              headerAnimationLoop: false,
                                              title: 'Can not save',
                                              desc: "Did you choose location?",
                                              btnOkOnPress: () {
                                                Navigator.of(context).pop();
                                              },
                                              btnOkIcon: Icons.cancel,
                                              btnOkColor: Colors.red,
                                            ).show();
                                          } else {
                                            if (autoverbalTypeValue == '100') {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                calLs(area);
                                                Navigator.of(context).pop();
                                              }

                                              ;
                                            } else {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                calElse(
                                                    area, autoverbalTypeValue);
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          }
                                          ;
                                          print(list);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.add,
                color: kImageColor,
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 22, right: 22),
          width: double.infinity,
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: list.length,
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
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  list[index]["Property"],
                                  style: NameProperty(),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      deleteItemToList(index);
                                      print(list);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                  child: Icon(
                                Icons.location_on_sharp,
                                color: kPrimaryColor,
                                size: 14,
                              )),
                              TextSpan(text: list[index]["address"]),
                            ],
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12),
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
                        child: Text(
                          list[index]["Description"],
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
                              Text(
                                ':   ' + list[index]["Depreciation"],
                                style: Name(),
                              ),
                              SizedBox(height: 2),
                              Text(
                                ':   ' +
                                    (list[index]["Area"].toInt()).toString() +
                                    'm' +
                                    '\u00B2',
                                style: Name(),
                              ),
                              SizedBox(height: 2),
                              Text(
                                ':   ' +
                                    (list[index]["minSqm"]).toString() +
                                    '\$',
                                style: Name(),
                              ),
                              SizedBox(height: 2),
                              Text(
                                ':   ' +
                                    (list[index]["maxSqm"]).toString() +
                                    '\$',
                                style: Name(),
                              ),
                              SizedBox(height: 2),
                              Text(
                                ':   ' +
                                    (list[index]["totalMin"]).toString() +
                                    '\$',
                                style: Name(),
                              ),
                              SizedBox(height: 2),
                              Text(
                                ':   ' +
                                    (list[index]["totalMax"].toString() + '\$'),
                                style: Name(),
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
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }

  void calLs(double area) {
    setState(() {
      maxSqm = ((widget.asking_price * (100 - max) / 100) +
          (((widget.asking_price * (100 - max)) / 100) * (widget.opt / 100)));
      minSqm = ((widget.asking_price * (100 - min) / 100) +
          (((widget.asking_price * (100 - min)) / 100) * (widget.opt / 100)));
      totalMin = (minSqm * area);
      totalMax = (maxSqm * area);
      print(widget.asking_price);
      print(minSqm);
      print(maxSqm);
      print(totalMin);
      print(totalMax);
      addItemToList();
    });
  }

  Future<void> calElse(double area, String autoverbalTypeValue) async {
    setState(() {
      isApiCallProcess = true;
    });
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/autoverbal/type?autoverbal_id=$autoverbalTypeValue'));
    //  if (rs.statusCode == 200) {
    var jsonData = jsonDecode(rs.body);
    setState(() {
      isApiCallProcess = false;
      // _list = jsonData['property'];
      maxSqm = double.parse(jsonData[0]['max']);
      minSqm = double.parse(jsonData[0]['min']);
      totalMin = minSqm * area;
      totalMax = maxSqm * area;
      print(minSqm);
      print(maxSqm);
      print(totalMin);
      print(totalMax);
      addItemToList();
    });
    //  }
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
