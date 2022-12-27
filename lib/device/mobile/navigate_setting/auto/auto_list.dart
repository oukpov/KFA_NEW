// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_adjacent_string_concatenation, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

class AutoList extends StatefulWidget {
  const AutoList({super.key});

  @override
  State<AutoList> createState() => _AutoListState();
}

class _AutoListState extends State<AutoList>
    with SingleTickerProviderStateMixin {
  late List M_v;
  late List N_v;

  static TabController? controller;
  static int index = 0;
  @override
  void initState() {
    controller = TabController(
        initialIndex: _AutoListState.index, length: Title.length, vsync: this);

    // TODO: implement initState
    super.initState();
  }

  List<String> Title = [
    "Khan Chamkar Mon",
    "Khan Doun Penh",
    "Khan 7 Makara",
    "Khan Tuol Kouk",
    "Khan Mean Chey",
    "Khan Chbar Ampov",
    "Khan Chroy Changvar",
    "Khan Sensok",
    "Khan Russey Keo",
    "Khan Dangkor",
    "Khan Pou Senchey",
    "Khan Preaek Pnov",
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Title.length,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("TabBarView1"),
            bottom: TabBar(
              controller: controller,
              isScrollable: true,
              tabs: [
                for (int i = 0; i < Title.length; i++)
                  Tab(child: Text(Title.elementAt(i))),
              ],
            )),
        body: TabBarView(controller: controller, children: [
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
          View_Data(
            srt: Title.elementAt(index),
          ),
        ]),
      ),
    );
  }
}

class View_Data extends StatefulWidget {
  const View_Data({super.key, required this.srt});
  final String srt;

  @override
  State<View_Data> createState() => _View_DataState();
}

class _View_DataState extends State<View_Data> {
  late List _list;
  TextStyle title = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 15,
    fontFamily: 'Anton',
    fontWeight: FontWeight.bold,
  );
  List<String> Title = [
    "Khan Chamkar Mon",
    "Khan Doun Penh",
    "Khan 7 Makara",
    "Khan Tuol Kouk",
    "Khan Mean Chey",
    "Khan Chbar Ampov",
    "Khan Chroy Changvar",
    "Khan Sensok",
    "Khan Russey Keo",
    "Khan Dangkor",
    "Khan Pou Senchey",
    "Khan Preaek Pnov",
  ];
  @override
  void initState() {
    Load();
    _list = [];
    print(widget.srt); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ((_list.length > 0)
        ? ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, i) {
              return Card(
                // height: 300,
                elevation: 10,
                color: Colors.blue[100],
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("Commune : ", style: title),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _list[i]['commune_name'],
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("District : ", style: title),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _list[i]['district'],
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("Province : ", style: title),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _list[i]['province'],
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text("Max value : ", style: title),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "${double.parse(_list[i]['max_value']).toStringAsFixed(2)} \$",
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text("Min value : ", style: title),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "${double.parse(_list[i]['min_value']).toStringAsFixed(2)} \$",
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text("Name's Road is : ", style: title),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _list[i]['road_name'],
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            })
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50.0),
            child: CircularProgressIndicator(),
          ));
  }

  void Load() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/apirc_list?district=${widget.srt}'));
    var jsonData = jsonDecode(rs.body);
    if (rs.statusCode == 200) {
      setState(() {
        _list = jsonData;
      });
    }
  }
}
