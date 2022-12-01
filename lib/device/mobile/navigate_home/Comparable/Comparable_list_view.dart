import 'package:admin/data/data.dart';
import 'package:admin/model/comparable.dart';
import 'package:admin/model/property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class ComparableList extends StatefulWidget {
  const ComparableList({super.key});

  @override
  State<ComparableList> createState() => _ComparableListState();
}

class _ComparableListState extends State<ComparableList> {
  // A function that converts a response body into a List<Photo>.
  static List<String> Idcom = [];
  Future<Comparable> com_data() async {
    final response = await http
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/comparable/list'));
    final data = jsonDecode(response.body);
    return Comparable.fromJson(data);
  }

  Future<properties> com_data_pty() async {
    final response = await http
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/property'));
    final data = jsonDecode(response.body);
    return properties.fromJson(data);
  }

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
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: com_data(),
        builder: (context, AsyncSnapshot<Comparable> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (context, index) {
              final cdt = snapshot.data!.data![index];
              // Idcom.add(cdt.comparableId!.toString());
              propertyID.forEach(
                (key, value) {
                  if (key == cdt.comparablePropertyId.toString()) {
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
                        Text(ch,
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

  Widget getProperty(BuildContext context) {
    return FutureBuilder(
      future: com_data_pty(),
      builder: (context, AsyncSnapshot<properties> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.property?.length,
          itemBuilder: (context, index) {
            final cdt = snapshot.data!.property![index];
            return Column(
              children: [
                Row(
                  children: [
                    Text("${cdt.propertyTypeId.toString()}"),
                    Text("${cdt.propertyTypeName.toString()}")
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}

// class PhotosList extends StatelessWidget {
//   const PhotosList({super.key, required this.item});

//   final List<Comparable> item;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         crossAxisSpacing: 2.0,
//       ),
//       itemCount: item.length,
//       itemBuilder: (context, index) {
//         return Container(
//           height: 700,
//           decoration: BoxDecoration(
//               color: Colors.blue[100], borderRadius: BorderRadius.circular(20)),
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.only(bottom: 10),
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   item[index].data[index].comparableCommuneId.toString(),
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
//                 ),
//                 // subtitle: Text("Job : ${item[index].title.toString()}"),
//                 trailing: Icon(
//                   Icons.favorite_border,
//                   color: Colors.red,
//                   size: 40,
//                 ),
//               ),
//               // Container(
//               //   height: MediaQuery.of(context).size.height * 0.5,
//               //   width: double.infinity,
//               //   decoration: BoxDecoration(
//               //       image: DecorationImage(
//               //           fit: BoxFit.cover,
//               //           image: NetworkImage(item[index].photo.toString()))),
//               // ),
//               // Text("This is My ex number ${item[index].id.toString()}"),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
