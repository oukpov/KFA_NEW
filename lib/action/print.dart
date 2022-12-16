// ignore_for_file: unused_import

import 'package:admin/Customs/Contants.dart';
import 'package:flutter/material.dart';

class Print extends StatefulWidget {
  const Print({super.key});

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        // ignore: prefer_const_constructors
        title:
            // ignore: prefer_const_constructors
            Text("Print", style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
