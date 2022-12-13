import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/getwidget.dart';

class AutoList extends StatefulWidget {
  const AutoList({super.key});

  @override
  State<AutoList> createState() => _AutoListState();
}

class _AutoListState extends State<AutoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListView(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.all(20),
      //       height: 200,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10), color: Colors.red),
      //       child: Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Text(
      //                   'Commune',
      //                   style: TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.bold),
      //                 ),
      //                 Text(
      //                   'Phum Thum',
      //                   style: TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.bold),
      //                 )
      //               ],
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Text(
      //                 'Commune',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 'Phum Thum',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               )
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Text(
      //                 'Commune',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 'Phum Thum',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               )
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Text(
      //                 'Commune',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 'Phum Thum',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               )
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Text(
      //                 'Commune',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 'Phum Thum',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //               )
      //             ],
      //           ),
      //           Divider(
      //             height: 10,
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
      //               IconButton(onPressed: () {}, icon: Icon(Icons.delete))
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: Column(
        
        children: [
          GFCard(
            borderRadius: BorderRadius.circular(20),
            elevation: 15,
            color: Colors.blue[50],
            title: GFListTile(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Commune',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Deistuct',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Province',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Main Road Max Value',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Sub Road Min value',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Sub Road Max Value',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Commune',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phum Thum',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // content: Text("Some quick example text to build on the card"),
            buttonBar: GFButtonBar(
              children: <Widget>[
                GFButton(
                  onPressed: () {},
                  text: 'Edit',
                  color: Color.fromARGB(255, 77, 161, 80),
                ),
                GFButton(
                  onPressed: () {},
                  text: 'Delete',
                  color: Color.fromARGB(255, 194, 29, 29),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
