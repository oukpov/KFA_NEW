import 'package:flutter/material.dart';

class MenuValuation extends StatefulWidget {
  MenuValuation({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MenuValuation> createState() => _MenuValuationState();
}

class _MenuValuationState extends State<MenuValuation> {
  List<Text> option = const [
    Text("New Executive",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Executive List",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text("Executive Approvals",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  ];
  List<Icon> optionIconList = const [
    Icon(Icons.add_circle),
    Icon(Icons.list_alt_outlined),
    Icon(Icons.app_registration),
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
      body: Column(
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
    );
  }
}
