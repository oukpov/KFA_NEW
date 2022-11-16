import 'package:admin/device/mobile/AutoVerbal/AutoVerbal.dart';
import 'package:admin/device/mobile/AutoVerbal/Setdata.dart';
import 'package:admin/device/mobile/comparable/Comparable_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenuAutoVerbal extends StatefulWidget {
  const MenuAutoVerbal({super.key});

  @override
  State<MenuAutoVerbal> createState() => _MenuAutoVerbalState();
}

class _MenuAutoVerbalState extends State<MenuAutoVerbal> {
  List<Text> option = const [
    Text("New Auto Verbal",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text(" Auto Verbal List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.data_saver_on),
    Icon(Icons.list_alt_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          " Auto Verbal",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < option.length; i++)
            InkWell(
              onTap: () {
                if (i == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Show_autoVerbal()));
                }
                if (i == 0) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Add()));
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
              ),
            ),
        ],
      ),
    );
  }
}
