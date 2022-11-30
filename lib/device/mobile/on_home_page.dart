import 'package:admin/Memory/Local_data.dart';
import 'package:admin/components/Google_Map.dart';
import 'package:admin/device/mobile/AutoVerbal/menu.dart';
import 'package:admin/device/mobile/Customer/menu.dart';
import 'package:admin/device/mobile/Property/menu.dart';
import 'package:admin/device/mobile/Report/menu.dart';
import 'package:admin/device/mobile/User/menu.dart';
import 'package:admin/device/mobile/Valuation/menu.dart';
import 'package:admin/device/mobile/Verbal/menu.dart';
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
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Valuation",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Comparable",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Property",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Auto Verbal",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Verbal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Report", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.group_rounded),
    Icon(Icons.price_change_rounded),
    Icon(Icons.compare_rounded),
    Icon(Icons.view_cozy_rounded),
    Icon(Icons.preview_rounded),
    Icon(Icons.visibility_rounded),
    Icon(Icons.person_pin_outlined),
    Icon(Icons.report_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
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
                        builder: (context) => MenuValuation(id: '17')));
                  }
                  if (i == 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuComparable()));
                  }
                  if (i == 3) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuProperty(
                              id: "17",
                            )));
                  }
                  if (i == 4) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuAutoVerbal(id: widget.id)));
                  }
                  if (i == 5) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuVerbal(
                              id: "17",
                            )));
                  }
                  if (i == 6) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuUser(
                              id: "17",
                            )));
                  }
                  if (i == 7) {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => MenuReport(
                    //           id: "17",
                    //         )));
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.success,
                      showCloseIcon: false,
                      title: "value.message",
                      autoHide: Duration(seconds: 3),
                      onDismissCallback: (type) {},
                    ).show();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Google_Map()));
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
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
                        const Icon(
                          Icons.forward,
                          size: 35,
                        )
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
