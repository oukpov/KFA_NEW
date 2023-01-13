// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_const

import 'package:admin/components/Google_Map.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/menu.dart';
import 'package:admin/device/mobile/navigate_home/Comparable/menu.dart';
import 'package:admin/device/mobile/navigate_home/Customer/menu.dart';
import 'package:admin/device/mobile/navigate_home/Property/menu.dart';
import 'package:admin/device/mobile/navigate_home/Report/menu.dart';
import 'package:admin/device/mobile/navigate_home/User/menu.dart';
import 'package:admin/device/mobile/navigate_home/Valuation/menu.dart';
import 'package:admin/device/mobile/navigate_home/Verbal/menu.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class NoBodyHome extends StatefulWidget {
  const NoBodyHome({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<NoBodyHome> createState() => _NoBodyHomeState();
}

class _NoBodyHomeState extends State<NoBodyHome> {
  List<Text> option = const [
    Text("Costomer",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Valuation",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Comparable",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Property",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Auto Verbal",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Verbal",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("User",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
    Text("Report",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.group_rounded, color: Colors.white),
    Icon(Icons.price_change_rounded, color: Colors.white),
    Icon(Icons.compare_rounded, color: Colors.white),
    Icon(Icons.view_cozy_rounded, color: Colors.white),
    Icon(Icons.preview_rounded, color: Colors.white),
    Icon(Icons.visibility_rounded, color: Colors.white),
    Icon(Icons.person_pin_outlined, color: Colors.white),
    Icon(Icons.report_rounded, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(
          //   height: 2,
          // ),
          for (int i = 0; i < 8; i++)
            InkWell(
              hoverColor: Color.fromARGB(161, 255, 249, 87),
              onTap: () {
                if (i == 0) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuCostome(
                            id: widget.id,
                          )));
                }
                if (i == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuValuation(
                            id: widget.id,
                          )));
                }
                if (i == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuComparable()));
                }
                if (i == 3) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuProperty(
                            id: widget.id,
                          )));
                }
                if (i == 4) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuAutoVerbal(id: widget.id)));
                }
                if (i == 5) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuVerbal(
                            id: widget.id,
                          )));
                }
                if (i == 6) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuUser(
                            id: widget.id,
                          )));
                }
                if (i == 7) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuReport(
                            id: "17",
                          )));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan,
                        Colors.indigo,
                      ],
                    ),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Color.fromARGB(255, 130, 68, 147),
                    //     Color.fromARGB(255, 102, 139, 234),
                    //     // Color.fromARGB(255, 193, 224, 80),
                    //   ],
                    //   end: Alignment.bottomLeft,
                    //   begin: Alignment.topRight,
                    //   // stops: [0.7, 0.2],
                    //   tileMode: TileMode.decal,
                    // ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topRight: Radius.circular(45)),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 2,
                          color: Color.fromARGB(157, 0, 0, 0),
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}
