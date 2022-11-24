import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class On_property extends StatefulWidget {
  const On_property({super.key});

  @override
  State<On_property> createState() => _On_propertyState();
}

class _On_propertyState extends State<On_property> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text("Show proerty"),
        )
      ],
    );
  }
}
