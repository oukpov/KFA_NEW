// ignore_for_file: prefer_const_constructors

import '../components/contants.dart';
import 'package:flutter/material.dart';

class FormS extends StatelessWidget {
  final String label;
  final Widget iconname;
  final String? addresse1;
  final FormFieldSetter<String> onSaved;
  const FormS({
    Key? key,
    this.addresse1,
    required this.label,
    required this.iconname,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        // controller: controller,
        onSaved: onSaved,
        decoration: InputDecoration(
          fillColor: kwhite,
          filled: true,
          labelText: ((addresse1 == null) ? label : addresse1),
          prefixIcon: iconname,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
