// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:admin/Customs/form.dart';
import 'package:admin/Customs/formTwinN.dart';
import 'package:admin/components/ApprovebyAndVerifyby.dart';
import 'package:admin/components/FileOpen.dart';
import 'package:admin/components/LandBuilding.dart';
import 'package:admin/components/comment.dart';
import 'package:admin/components/contants.dart';
import 'package:admin/components/date.dart';
import 'package:admin/components/forceSale.dart';
import 'package:admin/components/imageOpen.dart';
import 'package:admin/components/slideUp.dart';
import 'package:admin/device/mobile/AutoVerbal/check.dart';
import 'package:admin/device/mobile/AutoVerbal/property.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:admin/respon.dart';
import 'package:admin/server/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  APIservice apIservice = APIservice();
  int opt = 0;
  static double asking_price = 1;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
  String userID = '17';
  var code;
  var from = [
    'Bank',
    'Private',
    'Other',
  ];
  var gender = [
    'Female',
    'Male',
    'Other',
  ];
  var _list = [];
  List<dynamic> _branch = [];
  static String bankvalue = "6480";
  static String branchvalue = "";
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  @override
  void initState() {
    asking_price;
    bankvalue = "";
    // ignore: unnecessary_new
    Load();
    branch(bankvalue);
    _list;
    _branch;
    super.initState();
    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: "",
      lat: "",
      lng: "",
      address: '',
      approve_id: "", agent: "",
      bank_branch_id: "",
      bank_contact: "",
      bank_id: "",
      bank_officer: "",
      code: "",
      comment: "",
      contact: "",
      date: "",
      image: "",
      option: "",
      owner: "",
      user: "10",
      verbal_com: '',
      verbal_con: "",
      verbal: [],
      // autoVerbal: [requestModelVerbal],
      // data: requestModelVerbal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            color: kwhite,
            //style: IconButton.styleFrom(backgroundColor: kImageColor),
            onPressed: () {
              setState(() {
                requestModelAuto.user = "17";
                print(requestModelAuto.user);
                APIservice apIservice = APIservice();
                apIservice.saveAutoVerbal(requestModelAuto).then(
                  (value) {
                    // print('Error');
                    if (requestModelAuto.verbal.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Error',
                        desc: "Please add Land/Building at least 1!",
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red,
                      ).show();
                    } else {
                      if (value.message == "Save Successfully") {
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            headerAnimationLoop: false,
                            dialogType: DialogType.success,
                            showCloseIcon: false,
                            title: value.message,
                            autoHide: Duration(seconds: 3),
                            onDismissCallback: (type) {
                              Navigator.pop(context);
                            }).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: value.message,
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                        print(value.message);
                      }
                    }
                  },
                );
              });
            },
          ),
        ],
        title: Text.rich(
          TextSpan(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextSpan(
                text: "ADD ONE CLICK ",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kwhite,
                ),
              ),
              TextSpan(
                text: "1\$",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: kerror,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 80,
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Responsive(
              mobile: addVerbal(context),
              tablet: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: addVerbal(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: addVerbal(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              phone: addVerbal(context),
            ),
          ),
        ),
      ),
    );
  }

  Column addVerbal(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Code(
                  code: (value) {
                    code = value;
                  },
                ),
                // dropdown(),
                // PropertyDropdown(
                //   id: (value) {},
                //   name: (value) {},
                // ),
                SizedBox(
                  height: 10.0,
                ),
                PropertyDropdown(
                  name: (value) {
                    propertyType = value;
                  },
                  id: (value) {
                    requestModelAuto.property_type_id = value;
                  },
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // BankDropdown(),
                Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.65,
                    onChanged: (newValue) {
                      setState(() {
                        bankvalue = newValue!;
                        // ignore: avoid_print
                        setState(() {
                          branch(bankvalue);
                          requestModelAuto.bank_id = bankvalue;
                        });
                        print(bankvalue);
                        print("Value of bank  ${newValue}");
                      });
                    },
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please select bank';
                      }
                      return null;
                    },
                    items: _list
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                            value: value["bank_id"].toString(),
                            child: Text(value["bank_name"]),
                          ),
                        )
                        .toList(),
                    // add extra sugar..
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kImageColor,
                    ),

                    decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      labelText: 'Bank',
                      hintText: 'Select',

                      prefixIcon: Icon(
                        Icons.home_work,
                        color: kImageColor,
                        size: 20,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: kerror,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //   decoration: InputDecoration(
                      //       labelText: 'From',
                      //       prefixIcon: Icon(Icons.business_outlined)),
                    ),
                  ),
                ),

                ((_branch.length <= 1)
                    ? SizedBox(
                        height: 0.1,
                      )
                    : Container(
                        height: 70,
                        margin: EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          // autofocus: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              branchvalue = newValue!;
                              // ignore: avoid_print
                              requestModelAuto.bank_branch_id = branchvalue;
                              print("This id in branch ${newValue}");
                            });
                            ;
                          },
                          items: _branch
                              .map<DropdownMenuItem<String>>(
                                (value) => DropdownMenuItem<String>(
                                  value: value["bank_branch_id"].toString(),
                                  child: Text(
                                    value["bank_branch_name"],
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            14),
                                  ),
                                ),
                              )
                              .toList(),
                          // add extra sugar..
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: kImageColor,
                          ),

                          decoration: InputDecoration(
                            fillColor: kwhite,
                            filled: true,
                            labelText: 'Branch',
                            hintText: 'Select',

                            prefixIcon: Icon(
                              Icons.account_tree_rounded,
                              color: kImageColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: kPrimaryColor, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: kerror,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 5,
                                color: kerror,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //   decoration: InputDecoration(
                            //       labelText: 'From',
                            //       prefixIcon: Icon(Icons.business_outlined)),
                          ),
                        ),
                      )),
                SizedBox(
                  height: 10.0,
                ),
                FormTwinN(
                  Label1: 'Owner',
                  Label2: 'Contact',
                  onSaved1: (input) {
                    requestModelAuto.owner = input!;
                  },
                  onSaved2: (input) {
                    requestModelAuto.contact = input!;
                  },
                  icon1: Icon(
                    Icons.person,
                    color: kImageColor,
                    size: 20,
                  ),
                  icon2: Icon(
                    Icons.phone,
                    color: kImageColor,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DateComponents(
                  date: (value) {
                    requestModelAuto.date = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FormTwinN(
                  Label1: 'Bank Officer',
                  Label2: 'Contact',
                  onSaved1: (input) {
                    requestModelAuto.bank_officer = input!;
                  },
                  onSaved2: (input) {
                    requestModelAuto.bank_contact = input!;
                  },
                  icon1: Icon(
                    Icons.work,
                    color: kImageColor,
                  ),
                  icon2: Icon(
                    Icons.phone,
                    color: kImageColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ForceSaleAndValuation(),
                SizedBox(
                  height: 10,
                ),
                CommentAndOption(
                  value: (value) {
                    opt = int.parse(value);
                  },
                  id: (value) {
                    requestModelAuto.option = value;
                  },
                  comment: (String? newValue) {
                    requestModelAuto.comment = newValue!;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ApprovebyAndVerifyby(
                  approve: (value) {
                    requestModelAuto.approve_id = value;
                  },
                  verify: (value) {
                    requestModelAuto.agent = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FormS(
                  label: 'Address',
                  onSaved: (input) {
                    requestModelAuto.address = input!;
                  },
                  iconname: Icon(
                    Icons.location_on_rounded,
                    color: kImageColor,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                TextButton(
                  onPressed: () {
                    SlideUp(context);
                  },
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 30, right: 30),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.map_sharp,
                                  color: kImageColor,
                                ),
                                SizedBox(width: 10),
                                Text('Choose Location'),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                FileOpen(),
                SizedBox(
                  height: 10,
                ),
                ImageOpen(),
                SizedBox(height: 10),
                SizedBox(
                  height: 330,
                  child: LandBuilding(
                    asking_price: asking_price,
                    opt: opt,
                    address: address,
                    list: (value) {
                      requestModelAuto.verbal = value;
                    },
                    landId: code.toString(),
                  ),
                ),
                SizedBox(height: 10),
                // GFButton(
                //   text: "Submit",
                //   onPressed: () {
                //     setState(() {
                //       print("\nkokasd\n");
                //       requestModelAuto.user = userID.toString();
                //       if (validateAndSave()) {
                //         apIservice.saveAutoVerbal(requestModelAuto).then(
                //           (value) {
                //             print('Error');
                //             print(json.encode(requestModelAuto.toJson()));
                //             if (requestModelAuto.verbal.isEmpty) {
                //               AwesomeDialog(
                //                 context: context,
                //                 dialogType: DialogType.error,
                //                 animType: AnimType.rightSlide,
                //                 headerAnimationLoop: false,
                //                 title: 'Error',
                //                 desc: "Please add Land/Building at least 1!",
                //                 btnOkOnPress: () {},
                //                 btnOkIcon: Icons.cancel,
                //                 btnOkColor: Colors.red,
                //               ).show();
                //             } else {
                //               if (value.message == "Save Successfully") {
                //                 AwesomeDialog(
                //                     context: context,
                //                     animType: AnimType.leftSlide,
                //                     headerAnimationLoop: false,
                //                     dialogType: DialogType.success,
                //                     showCloseIcon: false,
                //                     title: value.message,
                //                     autoHide: Duration(seconds: 3),
                //                     onDismissCallback: (type) {
                //                       Navigator.pop(context);
                //                     }).show();
                //               } else {
                //                 AwesomeDialog(
                //                   context: context,
                //                   dialogType: DialogType.error,
                //                   animType: AnimType.rightSlide,
                //                   headerAnimationLoop: false,
                //                   title: 'Error',
                //                   desc: value.message,
                //                   btnOkOnPress: () {},
                //                   btnOkIcon: Icons.cancel,
                //                   btnOkColor: Colors.red,
                //                 ).show();
                //                 print(value.message);
                //               }
                //             }
                //           },
                //         );
                //       }
                //     });
                //   },
                // ),
                // TextButton(
                //     onPressed: () {
                //       // APIservice apIservice = APIservice();
                //       // apIservice.saveAutoVerbal(requestModelAuto).then(
                //       //   (value) {
                //       print(requestModelVerbal.toJson());
                //       print(requestModelAuto.toJson());
                //       //   },
                //       // );
                //     },
                //     child: Text('test')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> SlideUp(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SlidingUpPanelExample()),
    );
    if (!mounted) return;
    asking_price = result[0]['adding_price'];
    address = result[0]['address'];
    requestModelAuto.lat = result[0]['lat'];
    requestModelAuto.lng = result[0]['lng'];
  }

  void Load() async {
    setState(() {});
    var rs =
        await http.get(Uri.parse('https://kfahrm.cc/Laravel/public/api/bank'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      // print(jsonData);
      // print(jsonData);

      setState(() {
        _list = jsonData['banks'];
        print(_list[0]);
      });
    }
  }

  void branch(String pm) async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/bankbranch?bank_branch_details_id=$pm'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body.toString());
      // print(jsonData);
      setState(() {
        _branch = jsonData['bank_branches'];
      });
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
