// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_const, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:admin/Account/account.dart';
import 'package:admin/device/mobile/navigate_home/on_home_page.dart';
import 'package:admin/respon.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

import '../device/mobile/navigate_setting/memu_propety.dart';

class HomePage extends StatefulWidget {
  final String user;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  HomePage({
    Key? key,
    required this.user,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
  }) : super(key: key);
  String getUserInfo() {
    return this.user;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();
  static int pageIndex = 0;
  List pages = [];
  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );
  @override
  void initState() {
    pages = [
      NoBodyHome(
        id: widget.id,
      ),
      On_property(
        username: widget.user,
        email: widget.email,
        first_name: widget.first_name,
        last_name: widget.last_name,
        gender: widget.gender,
        from: widget.from,
        tel: widget.tel,
        id: widget.id,
      ),
      Account(
        username: widget.user,
        email: widget.email,
        first_name: widget.first_name,
        last_name: widget.last_name,
        gender: widget.gender,
        from: widget.from,
        tel: widget.tel,
        id: widget.id,
      ),
    ];
    print("widget id = " + widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 124, 148, 65),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const GFAvatar(
                  size: 140,
                  backgroundImage: AssetImage("assets/images/r.jpg"),
                ),
                Container(
                  height: 100.0,
                  // use name's widget.user
                  child: Text('User Name',
                      style: TextStyle(
                        //color: Color.fromRGBO(169, 203, 56, 1),
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).textScaleFactor * 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('info@kfa.com.kh | (855) 23 999 855'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[900],
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('KFA\' ONE CLICK  1\$',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(color: Colors.white)),
                  ],
                  pause: const Duration(milliseconds: 300),
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.auto_graph_outlined,
                size: 40,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Responsive(
            mobile: pages[pageIndex],
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: pages[pageIndex],
                      ),
                    ],
                  ),
                )
              ],
            ),
            desktop: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: pages[pageIndex],
                )
              ],
            ),
            phone: pages[pageIndex],
          ),
        ),
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepPurple[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }

  Widget appbar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.deepPurple[900],
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('KFA\' ONE CLICK  1\$'),
                  ],
                  pause: const Duration(milliseconds: 300),
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.auto_graph_outlined,
                size: 40,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ],
    );
  }
}
