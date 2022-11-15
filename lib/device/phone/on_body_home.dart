import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnBody_Home extends StatefulWidget {
  const OnBody_Home({super.key});

  @override
  State<OnBody_Home> createState() => _OnBody_HomeState();
}

class _OnBody_HomeState extends State<OnBody_Home> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(100, (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      }),
    );
  }
}
