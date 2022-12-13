import 'package:admin/device/mobile/navigate_setting/auto/auto_list.dart';
import 'package:flutter/material.dart';

import 'new_auto.dart';

class MenuAuto extends StatefulWidget {
  const MenuAuto({super.key});

  @override
  State<MenuAuto> createState() => _MenuAutoState();
}

List<Text> optionText = const [
  Text(
    "New Auto",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
  ),
  Text(
    "Auto List",
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
  )
];
List<Icon> optionIcon = const [
  Icon(Icons.new_label_outlined),
  Icon(Icons.audio_file)
];

class _MenuAutoState extends State<MenuAuto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Auto",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < optionIcon.length; i++)
            InkWell(
                onTap: () {
                  setState(() {
                    if (i == 0) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NewAuto()));
                    }
                    if (i == 1) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AutoList()));
                    }
                  });
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Color.fromARGB(157, 103, 94, 91),
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: optionIcon.elementAt(i),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: optionText.elementAt(i),
                      )
                    ],
                  ),
                )),
        ]),
      ),
    );
  }
}