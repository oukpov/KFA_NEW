// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'contants.dart';

typedef OnChangeCallback = void Function(dynamic value);

class ApprovebyAndVerifyby extends StatefulWidget {
  const ApprovebyAndVerifyby(
      {Key? key,
      this.approvee,
      required this.approve,
      required this.verify,
      this.verifye,
      this.label,
      this.Label1})
      : super(key: key);
  final OnChangeCallback approve;
  final OnChangeCallback verify;
  final String? verifye;
  final String? label;
  final String? Label1;
  final String? approvee;
  @override
  State<ApprovebyAndVerifyby> createState() => _ApprovebyAndVerifybyState();
}

class _ApprovebyAndVerifybyState extends State<ApprovebyAndVerifyby> {
  String valueapp = '';
  String valueagent = '';
  late List<dynamic> listApprove;
  late List<dynamic> listVerify;
  @override
  void initState() {
    super.initState();
    listApprove = [];
    listVerify = [];
    // ignore: unnecessary_new
    LoadApprove();
    LoadVerify();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.only(left: 30),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  valueagent = newValue!;
                  // ignore: avoid_print
                  widget.verify(valueagent);
                  print(newValue);
                });
              },
              items: listVerify
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["agenttype_id"],
                      child: Text(value["agenttype_name"]),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText:
                    ((widget.verifye == null) ? widget.label : widget.verifye),
                hintText: 'Select one',
                prefixIcon: Icon(
                  Icons.person_sharp,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 55,
            padding: EdgeInsets.only(right: 30),
            child: DropdownButtonFormField<String>(
              //value: genderValue,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  valueapp = newValue!;
                  // ignore: avoid_print
                  widget.approve(valueapp);
                  print(newValue);
                });
              },
              items: listApprove
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value["approve_id"],
                      child: Text(value["approve_name"]),
                    ),
                  )
                  .toList(),
              // add extra sugar..
              icon: Icon(
                Icons.arrow_drop_down,
                color: kImageColor,
              ),

              decoration: InputDecoration(
                fillColor: kwhite,
                filled: true,
                labelText: ((widget.approvee == null)
                    ? widget.Label1
                    : widget.approvee),
                hintText: 'Select one',
                prefixIcon: Icon(
                  Icons.person_outlined,
                  color: kImageColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void LoadApprove() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/approve?approve_published=0'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        listApprove = jsonData;
        // print(_list);
      });
    }
  }

  void LoadVerify() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/verify_by?agenttype_published=0'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        listVerify = jsonData;
        //print(_list);
      });
    }
  }
}
