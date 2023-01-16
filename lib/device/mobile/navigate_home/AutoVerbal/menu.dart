// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:admin/device/mobile/navigate_home/AutoVerbal/AutoVerbal.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/Setdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenuAutoVerbal extends StatefulWidget {
  MenuAutoVerbal({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuAutoVerbal> createState() => _MenuAutoVerbalState();
}

class _MenuAutoVerbalState extends State<MenuAutoVerbal> {
  List<Text> option = const [
    Text("New Auto Verbal",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
    Text(" Auto Verbal List",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.data_saver_on, color: Colors.white),
    Icon(Icons.list_alt_outlined, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: const Text(
          " Auto Verbal",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < option.length; i++)
              InkWell(
                onTap: () {
                  if (i == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Show_autoVerbals()));
                  }
                  if (i == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Add(
                              id: widget.id,
                            )));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.indigo,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 2,
                            color: Colors.black,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: optionIconList.elementAt(i),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: option.elementAt(i),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
