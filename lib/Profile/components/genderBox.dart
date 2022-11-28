// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:admin/Profile/components/Drop_down.dart';
import 'package:flutter/material.dart';

class GenderBox extends StatelessWidget {
  final String gender;
  final String from;
  const GenderBox({
    Key? key,
    required this.gender,
    required this.from,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dropdown(
          gender: gender,
        ),
        SizedBox(
          width: 6,
        ),
        // BankDropdown(
        //   from: from,
        // ),
      ],
    );
  }
}
