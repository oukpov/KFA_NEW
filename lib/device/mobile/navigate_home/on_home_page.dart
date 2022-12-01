import 'package:admin/components/Google_Map.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/menu.dart';
import 'package:admin/device/mobile/navigate_home/Customer/menu.dart';
import 'package:admin/device/mobile/navigate_home/Property/menu.dart';
import 'package:admin/device/mobile/navigate_home/Report/menu.dart';
import 'package:admin/device/mobile/navigate_home/User/menu.dart';
import 'package:admin/device/mobile/navigate_home/Valuation/menu.dart';
import 'package:admin/device/mobile/navigate_home/Verbal/menu.dart';
import 'package:admin/device/mobile/comparable/menu.dart';
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
              hoverColor: Colors.brown[100],
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
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.blue],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 2,
                            color: Color.fromARGB(157, 103, 94, 91),
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: optionIconList.elementAt(i),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: option.elementAt(i),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/KFA-Logo.png',
                        height: 40,
                        width: 60,
                      ),
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
