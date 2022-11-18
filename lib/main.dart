import 'package:admin/device/mobile/AutoVerbal/AutoVerbal.dart';
import 'package:admin/device/mobile/comparable/Comparable_list_view.dart';
import 'package:admin/device/mobile/on_home_page.dart';
import 'package:flutter/material.dart';

import 'interface/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home: Hompage(),
=======
      home: Show_autoVerbals(),
>>>>>>> bc5f6e39ac59204a821b97bd2000a2ab24abf5c1
    );
  }
}
