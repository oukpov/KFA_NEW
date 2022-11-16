import 'package:admin/data/data.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Show_autoVerbal extends StatefulWidget {
  const Show_autoVerbal({super.key});

  @override
  State<Show_autoVerbal> createState() => _Show_autoVerbalState();
}

class _Show_autoVerbalState extends State<Show_autoVerbal> {
  Future<List<AutoVerbal_List>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/autoverbal/list'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => new AutoVerbal_List.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "AutoVerbal List",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<AutoVerbal_List>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  final cdt = snapshot.data![index];
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 5)
                        ]),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Code :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.verbalId.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Property Type :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.propertyTypeName.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Address :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.verbalAddress.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text("Bank :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    15)),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(cdt.bankName.toString(),
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    14)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Agency :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.agenttypeName.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Create date :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.verbalCreatedDate.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          child: Container(
                            height: 5,
                            color: Colors.black,
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text("Server is not responding"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
