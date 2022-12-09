import 'dart:convert';

import 'package:admin/Customs/form.dart';
import 'package:admin/Customs/formTwinN.dart';
import 'package:admin/Customs/responsive.dart';
import 'package:admin/components/ApprovebyAndVerifyby.dart';
import 'package:admin/components/FileOpen.dart';
import 'package:admin/components/LandBuilding.dart';
import 'package:admin/components/bank.dart';
import 'package:admin/components/code.dart';
import 'package:admin/components/comment.dart';
import 'package:admin/components/contants.dart';
import 'package:admin/components/date.dart';
import 'package:admin/components/forceSale.dart';
import 'package:admin/components/imageOpen.dart';
import 'package:admin/components/slideUp.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/property.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:admin/server/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit extends StatefulWidget {
  const Edit(
      {super.key,
      required this.addresse,
      required this.approve,
      required this.verifye,
      required this.commente,
      required this.Vfee,
      required this.bankoff,
      required this.date1,
      required this.Contact,
      required this.ower,
      required this.id,
      required this.pro,
      required this.bn,
      required this.optointpye,
      required this.id_bn});
  final String addresse;
  final String approve;
  final String verifye;
  final String commente;
  final String optointpye;
  final String bankoff;
  final String date1;
  final String id;
  final String pro;
  final String bn;
  final String id_bn;
  final String ower;
  final String Contact;
  final String Vfee;
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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
        title: const Text.rich(
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
          decoration: const BoxDecoration(
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
                  cd: widget.id,
                  code: (value) {
                    code = value;
                  },
                ),
                // ignore: sized_box_for_whitespace
                //dropdown(),
                // PropertyDropdown(),
                // SizedBox(
                //   height: 10.0,
                // ),
                PropertyDropdown(
                  pro: widget.pro,
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
                  bn: widget.bn,
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
                  // Label1: 'Owner',
                  ower: widget.ower,
                  Label1: 'ower',
                  Contact: widget.Contact,
                  Label2: 'Contact',
                  // onSaved1: (input) {
                  //   requestModelAuto.owner = input!;
                  // },
                  onSaved1: (value) {
                    requestModelAuto.owner = value!;
                  },
                  onSaved2: (value) {
                    requestModelAuto.contact = value!;
                  },
                  icon1: const Icon(
                    Icons.person,
                    color: kImageColor,
                  ),
                  icon2: const Icon(
                    Icons.phone,
                    color: kImageColor,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DateComponents(
                  date1: widget.date1,
                  Label: 'Choose Date',
                  date: (value) {
                    requestModelAuto.date = value;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //////////////////////////////////////////////
                FormTwinN(
                  bankoff: widget.bankoff,
                  // bankoff: widget.bankoff,
                  // Label1: 'Bank Officer',
                  Label1: ('bankofficer'),
                  // Label1: ((widget.bankoff == null)
                  //     ? 'Bank officer'
                  //     : widget.bankoff),
                  Label2: 'Contact',
                  onSaved1: (Value) {
                    requestModelAuto.bank_officer = Value!;
                  },
                  onSaved2: (input) {
                    requestModelAuto.bank_contact = input!;
                  },
                  icon1: const Icon(
                    Icons.work,
                    color: kImageColor,
                  ),
                  icon2: const Icon(
                    Icons.phone,
                    color: kImageColor,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                ForceSaleAndValuation(
                  vfe: widget.Vfee,
                  value: (value) {
                    requestModelAuto.verbal_con = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

/////////////////////////////////////////////////////////////////////
                CommentAndOption(
                  optointpye: widget.optointpye,
                  label: 'OptionType',
                  value: (value) {
                    opt = int.parse(value);
                  },
                  id: (value) {
                    requestModelAuto.option = value;
                  },
                  commente: widget.commente,
                  Label1: 'Comment',
                  comment: (String? newValue) {
                    requestModelAuto.comment = newValue!;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ApprovebyAndVerifyby(
                  verifye: widget.verifye,
                  label: 'verify',
                  approve: (value) {
                    requestModelAuto.approve_id = value;
                  },
                  approvee: widget.approve,
                  Label1: 'Approve',
                  verify: (value) {
                    requestModelAuto.agent = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FormS(
                  addresse1: widget.addresse,
                  label: 'Address',
                  onSaved: (Value) {
                    requestModelAuto.address = Value!;
                  },
                  iconname: const Icon(
                    Icons.location_on_rounded,
                    color: kImageColor,
                  ),
                ),
                const SizedBox(
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 30, right: 30),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const SizedBox(width: 10),
                                const Icon(
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
                const SizedBox(
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
