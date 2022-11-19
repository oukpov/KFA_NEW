import 'package:admin/device/mobile/AutoVerbal/AutoVerbal.dart';
import 'package:admin/device/mobile/comparable/Comparable_list_view.dart';
import 'package:admin/device/mobile/on_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'interface/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const Hompage(),

      // home: Show_autoVerbals(),
    );
  }
}
