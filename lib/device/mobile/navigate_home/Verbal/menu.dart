// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MenuVerbal extends StatefulWidget {
  MenuVerbal({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuVerbal> createState() => _MenuVerbalState();
}

class _MenuVerbalState extends State<MenuVerbal> {
  List<Text> option = const [
    Text("New Verbal",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Verbal List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Verbal Search",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.add_circle),
    Icon(Icons.list_alt_outlined),
    Icon(Icons.search),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[800],
        centerTitle: true,
        title: const Text(
          "Costomer",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          image: const DecorationImage(
            alignment: Alignment.topCenter,
            image: ExactAssetImage('assets/images/KFA-Logo.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < option.length; i++)
              InkWell(
                onTap: () {},
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
      ),
    );
  }
}
