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

class _AutoListState extends State<AutoList> {
  late List _list;
  late List M_v;
  late List N_v;
  @override
  void initState() {
    _list = [];
    Load();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: (_list.length > 0)
            ? ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  return Container(
                      height: 300,
                      color: Colors.blue[100],
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Commune : "),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("District : "),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Province : "),
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
                        ],
                      ));
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void Load() async {
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/commune_list'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() async {
        _list = jsonData;
        for (int i = 0; i < _list.length; i++) {
          var rs = await http.get(Uri.parse(
              'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/rc_list?cid=${_list[i]['cid']}'));
          if (rs.statusCode == 200) {
            var jsonData = jsonDecode(rs.body);
            setState(() {
              M_v.add(jsonData[i]['max_value']);
              N_v.add(jsonData[i]['min_value']);
            });
          }
        }
        print(M_v);
      });
    }
  }
}
