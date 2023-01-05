// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:admin/model/models/autoVerbal.dart';

// import 'package:flutter_application_1/clone_youtube/user_model.dart';
import 'package:http/http.dart' as http;

class FetchUserList {
  var data = [];
  List<AutoVerbal_List> results = [];
  String urlList =
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list';

  Future<List<AutoVerbal_List>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => AutoVerbal_List.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.verbalId!
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
