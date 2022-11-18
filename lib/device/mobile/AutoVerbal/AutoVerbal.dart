import 'package:admin/model/models/autoVerbal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Show_autoVerbal extends StatefulWidget {
  const Show_autoVerbal({super.key});

  @override
  State<Show_autoVerbal> createState() => _Show_autoVerbalState();
}

class _Show_autoVerbalState extends State<Show_autoVerbal> {
  List<autoverbal> parsePhotos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<autoverbal>((json) => autoverbal.fromJson(json)).toList();
  }

  Future<List<autoverbal>> fetchPhotos(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/autoverbal/list'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return parsePhotos(response.body);
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPhotos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return PhotosList(photos: snapshot.data!);
      },
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<autoverbal> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Text(photos[index].verbalId.toString());
      },
    );
  }
}
