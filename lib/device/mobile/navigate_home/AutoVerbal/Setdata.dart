// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:admin/Customs/formTwinN.dart';
import 'package:admin/Customs/responsive.dart';
import 'package:admin/components/code.dart';
import 'package:admin/components/comment.dart';
import 'package:admin/components/forceSale.dart';
import 'package:admin/server/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../components/FileOpen.dart';
import '../../../../components/LandBuilding.dart';
import '../../../../components/bank.dart';
import '../../../../components/date.dart';
import '../../../../components/imageOpen.dart';
import '../../../../components/property.dart';
import '../../../../components/slideUp.dart';
import '../../../../contants.dart';
import '../../../../customs/form.dart';
import '../../../../model/models/autoVerbal.dart';

class Add extends StatefulWidget {
  const Add({super.key, required this.id});
  final String id;
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int opt = 0;
  double asking_price = 1;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  var code = 0;
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
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

  @override
  void initState() {
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
            // style: IconButton.styleFrom(backgroundColor: kImageColor),
            onPressed: () {
              requestModelAuto.user = widget.id;
              if (validateAndSave()) {
                APIservice apIservice = APIservice();
                apIservice.saveAutoVerbal(requestModelAuto).then(
                  (value) {
                    print('Error');
                    print(json.encode(requestModelAuto.toJson()));
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
                    ;
                  },
                );
              }
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
                // ignore: sized_box_for_whitespace
                //dropdown(),
                // PropertyDropdown(),
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
                SizedBox(
                  height: 10.0,
                ),
                BankDropdown(
                  bank: (value) {
                    requestModelAuto.bank_id = value;
                  },
                  bankbranch: (value) {
                    requestModelAuto.bank_branch_id = value;
                  },
                ),
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
                  ),
                  icon2: Icon(
                    Icons.phone,
                    color: kImageColor,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DateComponents(
                  Label: 'Choose Date',
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
                ForceSaleAndValuation(
                  value: (value) {
                    requestModelAuto.verbal_con = value;
                  },
                ),
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

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
