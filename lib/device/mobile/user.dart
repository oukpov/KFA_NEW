import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class On_User extends StatefulWidget {
  const On_User({super.key});

  @override
  State<On_User> createState() => _On_UserState();
}

class _On_UserState extends State<On_User> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text("User"),
        )
      ],
    );
  }
}
