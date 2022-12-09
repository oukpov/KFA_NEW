import 'package:flutter/material.dart';

class Field_box extends StatelessWidget {
  final String name;
  final String email;
  //final icon;
  const Field_box({
    Key? key,
    required this.name, required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 280,
        color: Colors.white,
        child: TextFormField(
          initialValue: email,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            labelText: name,
          ),
        ));
  }
}
