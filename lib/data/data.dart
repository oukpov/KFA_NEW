// import 'dart:convert';

// import 'package:admin/model/comparable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:http/http.dart' as http;

// class data {
//   static List<String> Com = [];
// }

// class All_data extends StatefulWidget {
//   const All_data({super.key});

//   @override
//   State<All_data> createState() => _All_dataState();
// }

// class _All_dataState extends State<All_data> with data {
//   Future<Comparable> com_data() async {
//     final response = await http
//         .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/comparable/list'));
//     final data = jsonDecode(response.body);
//     return Comparable.fromJson(data);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     com_data();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: com_data(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return ListView.builder(
//           itemCount: snapshot.data.data,
//           itemBuilder: (context, index) {
//             final cdt = snapshot.data!.data![index];
//             data.Com = cdt.comparableId.toString() as List<String>;
//             return InkWell();
//           },
//         );
//       },
//     );
//     ;
//   }
// }
