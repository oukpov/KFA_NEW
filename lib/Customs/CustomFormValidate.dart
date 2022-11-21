// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomFormValidate extends StatelessWidget {
  final String label;
  final Widget iconname;
  final FormFieldSetter<String> onSaved;
  const CustomFormValidate(
      {Key? key,
      required this.label,
      required this.iconname,
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        onSaved: onSaved,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: label,
          prefixIcon: iconname,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromRGBO(0, 126, 250, 1),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 249, 0, 0),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(255, 249, 0, 0),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (input) {
          if (input == null || input.isEmpty) {
            return 'require *';
          }
          return null;
        },
      ),
    );
  }
}