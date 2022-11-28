// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Customs/Contants.dart';

class Dropdown extends StatefulWidget {
  final String gender;
  const Dropdown({Key? key, required this.gender}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String bankvalue = 'Male';
  var gender = [
    'Male',
    'Female',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      width: 140,
      child: DropdownButtonFormField<String>(
        onChanged: (String? newValue) {
          setState(() {
            bankvalue = newValue!;
            // ignore: avoid_print
            print(newValue);
          });
        },
        // validator: (String? value) {
        //   if (value?.isEmpty ?? true) {
        //     return 'Please select bank';
        //   }
        //   return null;
        // },
        value: widget.gender,
        items: gender
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        // add extra sugar..
        icon: Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),

        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Gender',
          hintText: 'select one',
        ),
      ),
    );
  }
}
