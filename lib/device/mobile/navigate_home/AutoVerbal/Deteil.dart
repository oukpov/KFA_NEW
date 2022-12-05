import 'dart:convert';

import 'package:admin/Customs/LandBuildingDetail.dart';
import 'package:admin/Customs/responsive.dart';
import 'package:admin/Profile/contants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  const Detail({super.key, required this.id, required this.code});
  final int id;
  final String code;
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var code = 0;
  var list = [];

  @override
  void initState() {
    super.initState();
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "DETAIL ",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: kwhite,
          ),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Responsive(
              mobile: addVerbal(context),
              tablet: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: addVerbal(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: addVerbal(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              phone: addVerbal(context),
            ),
          ),
        ),
      ),
    );
  }

  Column addVerbal(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
      children: [
        list.length > 0
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 40),
                          Icon(
                            Icons.qr_code,
                            color: kImageColor,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.code,
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      ),

                      // ignore: sized_box_for_whitespace
                      //dropdown(),
                      // PropertyDropdown(),

                      Box(
                        label: "Property",
                        iconname: Icon(
                          Icons.business_outlined,
                          color: kImageColor,
                        ),
                        value: list[0]["property_type_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Bank",
                        iconname: Icon(
                          Icons.home_work,
                          color: kImageColor,
                        ),
                        value: list[0]["bank_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Branch",
                        iconname: Icon(
                          Icons.account_tree_rounded,
                          color: kImageColor,
                        ),
                        value: list[0]["bank_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Owner",
                        iconname: Icon(
                          Icons.person,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_owner"] ?? "N/A",
                      ),
                      Box(
                        label: "Contact",
                        iconname: Icon(
                          Icons.phone,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_contact"] ?? "N/A",
                      ),
                      Box(
                        label: "Date",
                        iconname: Icon(
                          Icons.calendar_today,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_created_date"].split(" ")[0] ??
                            "N/A",
                      ),
                      Box(
                        label: "Bank Officer",
                        iconname: Icon(
                          Icons.work,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_bank_officer"] ?? "N/A",
                      ),
                      Box(
                        label: "Contact",
                        iconname: Icon(
                          Icons.phone,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_bank_contact"] ?? "N/A",
                      ),

                      Box(
                        label: "Comment",
                        iconname: Icon(
                          Icons.comment_sharp,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_comment"] ?? "N/A",
                      ),
                      Box(
                        label: "Verify by",
                        iconname: Icon(
                          Icons.person_sharp,
                          color: kImageColor,
                        ),
                        value: list[0]["agenttype_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Approve by",
                        iconname: Icon(
                          Icons.person_outlined,
                          color: kImageColor,
                        ),
                        value: list[0]["approve_name"] ?? "N/A",
                      ),
                      Box(
                        label: "Address",
                        iconname: Icon(
                          Icons.location_on_rounded,
                          color: kImageColor,
                        ),
                        value: list[0]["verbal_address"] ?? "N/A",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 330,
                        child: LandBuildingDetail(
                          landId: code.toString(),
                          id: widget.code,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50.0),
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  void Load() async {
    var code = widget.code;
    print("hii" + code);
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/autoverbal/list?verbal_id=$code'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        list = jsonData;
        print(list[0]["verbal_bank_officer"]);
      });
    }
  }

  void get_user() async {
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/autoverbal/list?verbal_id=$code'));
  }
}

class Box extends StatelessWidget {
  final String label;
  final String value;
  final Widget iconname;

  const Box({
    Key? key,
    required this.label,
    required this.iconname,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: TextFormField(
        // controller: controller,
        initialValue: value,
        readOnly: true,

        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          labelText: label,
          prefixIcon: iconname,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
