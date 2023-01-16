// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:admin/Customs/formVLDN.dart';
import 'package:admin/Customs/formnum.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Customs/Contants.dart';
import '../Customs/ProgressHUD.dart';
import '../customs/form.dart';

import 'autoVerbalType.dart';

typedef OnChangeCallback = void Function(dynamic value);

class LandBuilding extends StatefulWidget {
  final double asking_price;
  final String address;
  final int opt;
  final String landId;
  final String khan;
  final OnChangeCallback list;
  final OnChangeCallback Avt;
  const LandBuilding({
    super.key,
    required this.asking_price,
    required this.opt,
    required this.address,
    required this.list,
    required this.landId,
    required this.khan,
    required this.Avt,
  });

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
  var dropdown;
  //sangkat
  late String propertyValue_sangkat;
  late String getname_sangkat;
  late List name_sangkat;
  late List<dynamic> list_sangkat;
  String? options;
  var _selectedValue;
  List<String> option = [
    'Residencial',
    'Commercial',
    'Agricultural',
  ];
  void Load_khan() async {
    var k_id = widget.khan;
    // setState(() {
    //   k_id;
    // });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/sangkat?Khan_ID=${k_id}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list_sangkat = jsonData;
        print(
            "=================>length sangkat ${list_sangkat[0]['Sangkat_Name']}<==================");
      });
    }
  }

  // late int asking_price;
  void addItemToList() {
    print(widget.asking_price);
    setState(() {
      list.add({
        "verbal_land_type": autoverbalType,
        "verbal_land_des": des,
        "verbal_land_dp": dep,
        "verbal_land_area": area,
        "verbal_land_minsqm": minSqm.toStringAsFixed(0),
        "verbal_land_maxsqm": maxSqm.toStringAsFixed(0),
        "verbal_land_minvalue": totalMin.toStringAsFixed(0),
        "verbal_land_maxvalue": totalMax.toStringAsFixed(0),
        "address": widget.address,
        "verbal_landid": widget.landId
      });
      widget.list(list);
      minSqm = 0;
      maxSqm = 0;
      totalMax = 0;
      totalMin = 0;
      area = 0;

      print('list:');
      print(list);
      print('listAuto:');
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
    Load_khan();
    propertyValue_sangkat = "";
    getname_sangkat = "";
    name_sangkat = [];
    list_sangkat = [];
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            "Land/Building",
            style: TextStyle(color: kImageColor, fontSize: 20),
          ),
        ),
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  child: AutoVerbalTypeDropdown(
                    name: (value) {
                      autoverbalType = value;
                    },
                    id: (value) {
                      autoverbalTypeValue = value;
                      setState(() {
                        widget.Avt(autoverbalTypeValue);
                      });
                    },
                  ),
                ),
                // if (autoverbalTypeValue == 100)
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
                    onSaved: (newValue) => area = double.parse(newValue!),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                (autoverbalTypeValue == '100')
                    ? Column(
                        children: [
                          Container(
                            height: 57,
                            margin:
                                EdgeInsets.only(left: 30, top: 10, right: 30),
                            // padding: const EdgeInsets.all(2),
                            child: DropdownButtonFormField<String>(
                              value: _selectedValue,
                              // hint: Text(
                              //   'choose one',
                              // ),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  print(_selectedValue);
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },

                              items: option.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                  ),
                                );
                              }).toList(),
                              // add extra sugar..
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),

                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Option',
                                hintText: 'Select',

                                prefixIcon: Icon(
                                  Icons.pix_rounded,
                                  color: kImageColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: kPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                //   decoration: InputDecoration(
                                //       labelText: 'From',
                                //       prefixIcon: Icon(Icons.business_outlined)),
                              ),
                            ),
                          ),
                          Container(
                            height: 57,
                            margin:
                                EdgeInsets.only(left: 30, top: 10, right: 30),
                            // padding: const EdgeInsets.all(2),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  propertyValue_sangkat = newValue as String;

                                  // widget.bank(bankvalue);
                                  // branch(newValue.toString());
                                  print(newValue);
                                });
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select sangkat';
                                }
                                return null;
                              },
                              items: list_sangkat
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value["Sangkat_ID"].toString(),
                                      child: Text(
                                        value["Sangkat_Name"],
                                        style: TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          getname_sangkat =
                                              value["Sangkat_Name"];
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                              // add extra sugar..
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kImageColor,
                              ),

                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Sangkat',
                                hintText: 'Select',

                                prefixIcon: Icon(
                                  Icons.home_work,
                                  color: kImageColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: kPrimaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: kPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                //   decoration: InputDecoration(
                                //       labelText: 'From',
                                //       prefixIcon: Icon(Icons.business_outlined)),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(''),
                ElevatedButton(
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text("Calculator price")),
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          calLs(area);
                          // Navigator.of(context).pop();
                        }
                      } else {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          calElse(area, autoverbalTypeValue);
                          // Navigator.of(context).pop();
                        }
                      }
                    }
                  },
                ),
                // if (area != 0)
                Container(
                  padding: EdgeInsets.only(left: 22, right: 22),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                          list[index]["verbal_land_type"],
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                          text:
                                              "${list[index]["address"]} / Sangkat ${getname_sangkat}"),
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
                                  list[index]["verbal_land_des"],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        ':   ' + list[index]["verbal_land_dp"],
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (list[index]["verbal_land_area"]
                                                    .toInt())
                                                .toString() +
                                            'm' +
                                            '\u00B2',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (list[index]["verbal_land_minsqm"])
                                                .toString() +
                                            '\$',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (list[index]["verbal_land_maxsqm"])
                                                .toString() +
                                            '\$',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (list[index]
                                                    ["verbal_land_minvalue"])
                                                .toString() +
                                            '\$',
                                        style: Name(),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        ':   ' +
                                            (list[index]["verbal_land_maxvalue"]
                                                    .toString() +
                                                '\$'),
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
                    // separatorBuilder: (BuildContext context, int index) =>
                    //     const Divider(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget uiSteup(BuildContext context) {
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
                                  Navigator.pop(context, list);
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
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 400,
                                      child: AutoVerbalTypeDropdown(
                                        name: (value) {
                                          autoverbalType = value;
                                        },
                                        id: (value) {
                                          autoverbalTypeValue = value;
                                          setState(() {
                                            widget.Avt(autoverbalTypeValue);
                                          });
                                        },
                                      ),
                                    ),
                                    if (autoverbalTypeValue == 100)
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
        SizedBox(
          height: 300,
        ),
        if (totalMin != 0)
          Container(
            padding: EdgeInsets.only(left: 22, right: 22),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
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
                                    list[index]["verbal_land_type"],
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
                            list[index]["verbal_land_des"],
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
                                  ':   ' + list[index]["verbal_land_dp"],
                                  style: Name(),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  ':   ' +
                                      (list[index]["verbal_land_area"].toInt())
                                          .toString() +
                                      'm' +
                                      '\u00B2',
                                  style: Name(),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  ':   ' +
                                      (list[index]["verbal_land_minsqm"])
                                          .toString() +
                                      '\$',
                                  style: Name(),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  ':   ' +
                                      (list[index]["verbal_land_maxsqm"])
                                          .toString() +
                                      '\$',
                                  style: Name(),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  ':   ' +
                                      (list[index]["verbal_land_minvalue"])
                                          .toString() +
                                      '\$',
                                  style: Name(),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  ':   ' +
                                      (list[index]["verbal_land_maxvalue"]
                                              .toString() +
                                          '\$'),
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
              // separatorBuilder: (BuildContext context, int index) =>
              //     const Divider(),
            ),
          ),
      ],
    );
  }

  void calLs(double area) {
    var khan_id = widget.khan;
    setState(() async {
      if (_selectedValue == 'Commercial') {
        var rs = await http.get(Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commercial?Khan_ID=${khan_id}&Sangkat_ID=${propertyValue_sangkat}'));
        var jsonData = jsonDecode(rs.body);
        setState(() {
          maxSqm = double.parse(jsonData[0]['Max_Value']);
          minSqm = double.parse(jsonData[0]['Min_Value']);
        });
      } else if (_selectedValue == 'Residencial') {
        var rs = await http.get(Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/residential?Khan_ID=${khan_id}&Sangkat_ID=${propertyValue_sangkat}'));
        var jsonData = jsonDecode(rs.body);
        setState(() {
          maxSqm = double.parse(jsonData[0]['Max_Value']);
          minSqm = double.parse(jsonData[0]['Min_Value']);
        });
      } else if (_selectedValue == 'Agricultural') {
        maxSqm = 1;
        minSqm = 1;
      }
      // maxSqm = ((widget.asking_price * (100 - max) / 100) +
      //     (((widget.asking_price * (100 - max)) / 100) * (widget.opt / 100)));
      // minSqm = ((widget.asking_price * (100 - min) / 100) +
      //     (((widget.asking_price * (100 - min)) / 100) * (widget.opt / 100)));
      totalMin = (minSqm * area);
      totalMax = (maxSqm * area);
      // print(widget.asking_price);
      // print(minSqm);
      // print(maxSqm);
      // print(totalMin);
      // print(totalMax);
      addItemToList();
    });
  }

  Future<void> calElse(double area, String autoverbalTypeValue) async {
    setState(() {
      isApiCallProcess = true;
    });
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/type?autoverbal_id=$autoverbalTypeValue'));
    //  if (rs.statusCode == 200) {
    var jsonData = jsonDecode(rs.body);
    setState(() {
      isApiCallProcess = false;
      // _list = jsonData['property'];
      maxSqm = double.parse(jsonData[0]['max']);
      minSqm = double.parse(jsonData[0]['min']);
      totalMin = minSqm * area;
      totalMax = maxSqm * area;
      // print(minSqm);
      // print(maxSqm);
      // print(totalMin);
      // print(totalMax);
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
        color: kImageColor, fontSize: 11, fontWeight: FontWeight.bold);
  }
}
