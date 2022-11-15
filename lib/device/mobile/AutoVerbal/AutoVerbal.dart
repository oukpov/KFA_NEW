import 'package:admin/model/models/autoVerbal.dart';
import 'package:admin/model/models/auverbal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Show_autoVerbal extends StatefulWidget {
  const Show_autoVerbal({super.key});

  @override
  State<Show_autoVerbal> createState() => _Show_autoVerbalState();
}

class _Show_autoVerbalState extends State<Show_autoVerbal> {
  Future<verballist> atb() async {
    final response = await http
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/verbal'));
    final data = jsonDecode(response.body);
    return verballist.fromJson(data);
  }

  int k = 0;
  String l = "gfhghf";
  String p = "sdfhj";
  Map<String, String> propertyID = {
    '1': 'Agriculture',
    '2': 'Apartment',
    '3': 'Borey',
    '4': 'Building',
    '5': 'Business',
    '6': 'Condominium',
    '7': 'Deverlopment Land',
    '8': 'Duplex House',
    '9': 'Factory',
    '10': 'Flat',
    '11': 'Ges Station',
    '12': 'Guest House',
    '13': 'Hotel',
    '14': 'House',
    '15': 'Land',
    '16': 'Link House',
    '17': 'Marketing House',
    '18': 'Office Space',
    '19': 'Other',
    '20': 'Penthon',
    '21': 'Projet',
    '22': 'Report',
    '23': 'Restaurant',
    '24': 'Shop',
    '25': 'Shop House',
    '26': 'Shopping Center',
    '27': 'Store',
    '28': 'Twin House',
    '29': 'Villa',
    '30': 'Villa Share',
    '31': 'Warehouse',
    '32': 'Residence',
    '33': 'Vacant Land',
    '34': 'Industrial Park',
    '35': 'Casio',
    '36': 'Office Building',
  };
  static String ch = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: atb(),
        builder: (context, AsyncSnapshot<verballist> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            // itemCount: snaps
            itemBuilder: (context, index) {
              final cdt = snapshot.data!;
              // Idcom.add(cdt.comparableId!.toString());
              propertyID.forEach(
                (key, value) {
                  if (key == cdt.verbalPropertyId) {
                    ch = value;
                  }
                },
              );
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Property Type :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        15)),
                        Text(ch,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        14)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lang Size :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        15)),
                        Text(cdt.verbalCreatedBy.toString(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        14)),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
