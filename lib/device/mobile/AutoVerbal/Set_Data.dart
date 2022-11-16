import 'package:admin/Customs/Contants.dart';
import 'package:admin/Customs/form.dart';
import 'package:admin/Customs/formTwinN.dart';
import 'package:admin/components/ApprovebyAndVerifyby.dart';
import 'package:admin/components/FileOpen.dart';
import 'package:admin/components/LandBuilding.dart';
import 'package:admin/components/bank.dart';
import 'package:admin/components/code.dart';
import 'package:admin/components/comment.dart';
import 'package:admin/components/date.dart';
import 'package:admin/components/forceSale.dart';
import 'package:admin/components/imageOpen.dart';
import 'package:admin/components/property.dart';
import 'package:admin/components/slideUp.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:admin/respon.dart';
import 'package:flutter/material.dart';

class SetData extends StatefulWidget {
  const SetData({super.key});

  @override
  State<SetData> createState() => _SetDataState();
}

class _SetDataState extends State<SetData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  int opt = 0;
  double asking_price = 1;
  String address = '';
  String propertyType = '', propertyTypeValue = '';
  TextEditingController dateinput = TextEditingController();
  late AutoVerbalRequestModel requestModelAuto;
  late VerbalTypeRequestModel requestModelVerbal;
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
    requestModelVerbal = VerbalTypeRequestModel(
        verbal_land_area: '123',
        verbal_land_des: 'fgf',
        verbal_land_dp: '12',
        verbal_land_maxsqm: '12',
        verbal_land_maxvalue: '23',
        verbal_land_minsqm: '13',
        verbal_land_minvalue: '13',
        //   verbal_land_type: 'ls',
        verbal_landid: '12',
        verbal_land_type: 'LS');
    requestModelVerbal = VerbalTypeRequestModel(
        verbal_land_area: '122222222',
        verbal_land_des: 'fgf',
        verbal_land_dp: '12',
        verbal_land_maxsqm: '12',
        verbal_land_maxvalue: '23',
        verbal_land_minsqm: '13',
        verbal_land_minvalue: '13',
        //   verbal_land_type: 'ls',
        verbal_landid: '12',
        verbal_land_type: 'LS');
    requestModelAuto = AutoVerbalRequestModel(
      property_type_id: "1234",
      lat: "12",
      lng: "12",
      address: 'gdhfgd',
      approve_id: "dfhdf",
      bank_branch_id: "12",
      bank_contact: "1787424",
      bank_id: "12",
      bank_officer: "ffgf",
      code: "343645",
      comment: "dfgdf",
      contact: "jdhfj",
      date: "8843",
      image: "",
      option: "12",
      owner: "jgkjhg",
      user: "1",
      verbal_com: 'gfjgh',
      verbal_con: "fgf",
      data: requestModelVerbal,
      // autoVerbal: [requestModelVerbal],
      // data: requestModelVerbal,
    );
    print(requestModelVerbal.toJson());
    print(requestModelAuto.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[50],
      //   elevation: 0,
      //   centerTitle: true,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.save),
      //       color: Colors.white,
      //       //style: IconButton.styleFrom(backgroundColor: kImageColor),
      //       onPressed: () {},
      //     ),
      //   ],
      //   title: const Text.rich(
      //     TextSpan(
      //       // ignore: prefer_const_literals_to_create_immutables
      //       children: [
      //         TextSpan(
      //           text: "ADD ONE CLICK ",
      //           style: TextStyle(
      //             fontSize: 20.0,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.white,
      //           ),
      //         ),
      //         TextSpan(
      //           text: "1\$",
      //           style: TextStyle(
      //             fontSize: 40.0,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   toolbarHeight: 80,
      // ),
      backgroundColor: Colors.white,
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
                Code(),
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
                    propertyTypeValue = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                BankDropdown(),
                SizedBox(
                  height: 10.0,
                ),
                FormTwinN(
                  Label1: 'Owner',
                  Label2: 'Contact',
                  onSaved1: (input) {},
                  onSaved2: (input) {},
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
                DateComponents(),
                SizedBox(
                  height: 10.0,
                ),
                FormTwinN(
                  Label1: 'Bank Officer',
                  Label2: 'Contact',
                  onSaved1: (input) {},
                  onSaved2: (input) {},
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
                  name: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                ApprovebyAndVerifyby(),
                SizedBox(
                  height: 10.0,
                ),
                FormS(
                  label: 'Address',
                  onSaved: (input) {},
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
                  ),
                ),
                TextButton(
                    onPressed: () {
                      // APIservice apIservice = APIservice();
                      // apIservice.saveAutoVerbal(requestModelAuto).then(
                      //   (value) {
                      print(requestModelVerbal.toJson());
                      print(requestModelAuto.toJson());
                      //   },
                      // );
                    },
                    child: Text('test')),
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
  }
}
