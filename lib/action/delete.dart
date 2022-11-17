// import 'package:flutter/material.dart';
// class DeleteId extends StatefulWidget {
//   const DeleteId({super.key});

//   @override
//   State<DeleteId> createState() => _DeleteIdState();
// }

// class _DeleteIdState extends State<DeleteId> {
//   Future<List<AutoVerbal_List>> fetchData() async {
//     final response = await http
//         .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/autoverbal/list'));
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse
//           .map((data) => new AutoVerbal_List.fromJson(data))
//           .toList();
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//     );
//   }
// }