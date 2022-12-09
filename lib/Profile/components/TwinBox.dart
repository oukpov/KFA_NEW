// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TwinBox extends StatelessWidget {
  final String labelText1;
  final String labelText2;
  final String fname;
  final String lname;

  const TwinBox({
    Key? key,
    required this.labelText1,
    required this.labelText2,
    required this.fname,
    required this.lname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 140,
          color: Color.fromARGB(255, 255, 255, 255),
          child: TextFormField(
            initialValue: fname,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: labelText1,
            ),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Container(
          height: 60,
          width: 140,
          color: Color.fromARGB(255, 255, 255, 255),
          child: TextFormField(
            initialValue: lname,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: labelText2,
            ),
          ),
        )
      ],
    );
  }
}
