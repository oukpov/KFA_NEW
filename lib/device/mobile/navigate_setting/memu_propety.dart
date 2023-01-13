// ignore_for_file: unnecessary_import, implementation_imports, unused_import, non_constant_identifier_names, camel_case_types, prefer_const_constructors

import 'package:admin/device/mobile/navigate_setting/auto/menu_auto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../navigate_home/AutoVerbal/menu.dart';

class On_property extends StatefulWidget {
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  const On_property({
    Key? key,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
  }) : super(key: key);

  @override
  State<On_property> createState() => _On_propertyState();
}

class _On_propertyState extends State<On_property> {
  List<Text> option = const [
    Text("Biulding Type",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Register",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Auto",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Road",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Approved",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Bank",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Brand",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Agency",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Option",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Land",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Assign To",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Min & Max",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Province",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("District",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Commune",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
  ];
  List<Icon> optionIconList = [
    Icon(Icons.cabin, color: Colors.white),
    Icon(Icons.how_to_reg, color: Colors.white),
    Icon(Icons.auto_fix_high, color: Colors.white),
    Icon(Icons.edit_road, color: Colors.white),
    Icon(Icons.checklist_rtl, color: Colors.white),
    Icon(Icons.account_balance, color: Colors.white),
    Icon(Icons.support_agent, color: Colors.white),
    Icon(Icons.settings_applications, color: Colors.white),
    Icon(Icons.forest, color: Colors.white),
    Icon(Icons.assignment_ind, color: Colors.white),
    Icon(Icons.hourglass_empty, color: Colors.white),
    Icon(Icons.category, color: Colors.white),
    Icon(Icons.dashboard, color: Colors.white),
    Icon(Icons.calendar_view_month, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < optionIconList.length; i++)
            InkWell(
              hoverColor: Color.fromARGB(161, 255, 249, 87),
              onTap: () {
                setState(() {
                  if (i == 2) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MenuAuto()));
                  }
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 88, 130, 236),
                          Color.fromARGB(255, 142, 55, 110),

                          // Color.fromARGB(255, 193, 224, 80),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.8, 0.2],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 2,
                            color: Color.fromARGB(164, 0, 0, 0),
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 40,
                        width: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: option.elementAt(i),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: optionIconList.elementAt(i),
                      ),
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
