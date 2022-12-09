// ignore_for_file: prefer_const_constructors

import '../components/contants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

typedef OnChangeCallback = void Function(dynamic value);

class Code extends StatefulWidget {
  final OnChangeCallback code;
  const Code({
    Key? key,
    required this.code,
    this.cd,
  }) : super(key: key);
  final String? cd;
  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  late List code;
  bool loading = false;
  late int codedisplay;
  @override
  void initState() {
    Load();
    code = [];
    codedisplay = 0;
    super.initState();
  }

  void Load() async {
    setState(() {
      loading = true; //make loading true to show progressindicator
    });
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/verbal?verbal_published=0'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        loading = false;
        code = jsonData;
        codedisplay = int.parse(code[0]['verbal_id']) + 1;
        print(code[0]['verbal_id']);
        widget.code(codedisplay);
        print(codedisplay);

        // print(_list);
      });
      // print(list.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: loading
          ? Center(child: CircularProgressIndicator())
          : //if loading == true, show progress indicator
          Row(
              children: [
                SizedBox(width: 40),
                Icon(
                  Icons.qr_code,
                  color: kImageColor,
                  size: 30,
                ),
                SizedBox(width: 10),
                ((widget.cd == null)
                    ? Text(
                        codedisplay.toString(),
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      )
                    : Text(
                        widget.cd.toString(),
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      )),
              ],
            ),
    );
  }
}
