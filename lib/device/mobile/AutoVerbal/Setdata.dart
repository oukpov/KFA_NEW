// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:admin/Customs/form.dart';
import 'package:admin/Customs/formTwinN.dart';
import 'package:admin/components/ApprovebyAndVerifyby.dart';
import 'package:admin/components/FileOpen.dart';
import 'package:admin/components/LandBuilding.dart';
import 'package:admin/components/bank.dart';
import 'package:admin/components/comment.dart';
import 'package:admin/components/date.dart';
import 'package:admin/components/forceSale.dart';
import 'package:admin/components/imageOpen.dart';
import 'package:admin/components/slideUp.dart';
import 'package:admin/device/mobile/AutoVerbal/check.dart';
import 'package:admin/device/mobile/AutoVerbal/property.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:admin/respon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../components/contants.dart';

class Add extends StatefulWidget {
  const Add({super.key});

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
  var _list = [];
  var _branch = [];
  static String? bankvalue;
  static String branchvalue = "6467";
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];
  @override
  void initState() {
    bankvalue = "";
    // ignore: unnecessary_new
    Load();
    branch();
    super.initState();
    // requestModelVerbal = VerbalTypeRequestModel(
    //     verbal_land_area: '123',
    //     verbal_land_des: 'fgf',
    //     verbal_land_dp: '12',
    //     verbal_land_maxsqm: '12',
    //     verbal_land_maxvalue: '23',
    //     verbal_land_minsqm: '13',
    //     verbal_land_minvalue: '13',
    //     //   verbal_land_type: 'ls',
    //     verbal_landid: '12',
    //     verbal_land_type: 'LS');
    // requestModelVerbal = VerbalTypeRequestModel(
    //     verbal_land_area: '122222222',
    //     verbal_land_des: 'fgf',
    //     verbal_land_dp: '12',
    //     verbal_land_maxsqm: '12',
    //     verbal_land_maxvalue: '23',
    //     verbal_land_minsqm: '13',
    //     verbal_land_minvalue: '13',
    //     //   verbal_land_type: 'ls',
    //     verbal_landid: '12',
    //     verbal_land_type: 'LS');
    // requestModelAuto = AutoVerbalRequestModel(
    //   property_type_id: "1234",
    //   lat: "12",
    //   lng: "12",
    //   address: 'gdhfgd',
    //   approve_id: "dfhdf",
    //   bank_branch_id: "12",
    //   bank_contact: "1787424",
    //   bank_id: "12",
    //   bank_officer: "ffgf",
    //   code: "343645",
    //   comment: "dfgdf",
    //   contact: "jdhfj",
    //   date: "8843",
    //   image: "",
    //   option: "12",
    //   owner: "jgkjhg",
    //   user: "1",
    //   verbal_com: 'gfjgh',
    //   verbal_con: "fgf",
    //   data: requestModelVerbal, SetDataATBress: '',
    //   // autoVerbal: [requestModelVerbal],
    //   // data: requestModelVerbal,
    // );
    // print(requestModelVerbal.toJson());
    // print(requestModelAuto.toJson());
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
            onPressed: () {},
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
                Code(),
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
                    propertyTypeValue = value;
                  },
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // BankDropdown(),
                Container(
                  height: 55,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
                    onChanged: (newValue) {
                      setState(() {
                        bankvalue = newValue;
                        // ignore: avoid_print
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
                            child: Text(
                              value["bank_acronym"],
                              style: TextStyle(
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          12),
                              // maxLines: 9,
                              overflow: TextOverflow.clip,
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
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 55,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
                    onChanged: (newValue) {
                      setState(() {
                        // bankvalue = newValue;
                        // // ignore: avoid_print
                        // print(bankvalue);
                        // print("Value of bank  ${newValue}");
                      });
                    },
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please select bank';
                      }
                      return null;
                    },
                    items: _branch
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                            value: value["bank_branch_id"].toString(),
                            child: Text(
                              value["bank_branch_name"],
                              style: TextStyle(
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          12),
                              // maxLines: 9,
                              overflow: TextOverflow.clip,
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
      });
    }
  }

  void branch() async {
    setState(() {});
    var rs = await http.get(Uri.parse(
        // ignore: unnecessary_brace_in_string_interps
        'https://kfahrm.cc/Laravel/public/api/bankbranch?bank_branch_details_id=${branchvalue}'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body.toString());
      // print(jsonData);
      setState(() {
        _branch = jsonData['bank_branches'];
      });
    }
  }
}

// class PhotosList extends StatelessWidget {
//   const PhotosList({super.key, required this.item});

//   final List<Bankbranchlist> item;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         crossAxisSpacing: 2.0,
//       ),
//       itemCount: item.length,
//       itemBuilder: (context, index) {
//         return Container(
//           height: 700,
//           decoration: BoxDecoration(
//               color: Colors.blue[100], borderRadius: BorderRadius.circular(20)),
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.only(bottom: 10),
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   item[index].bankBranchId.toString(),
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
//                 ),
//                 subtitle:
//                     Text("Job : ${item[index].bankBranchName.toString()}"),
//                 trailing: Icon(
//                   Icons.favorite_border,
//                   color: Colors.red,
//                   size: 40,
//                 ),
//               ),
//               // Container(
//               //   height: MediaQuery.of(context).size.height * 0.5,
//               //   width: double.infinity,
//               //   decoration: BoxDecoration(
//               //       image: DecorationImage(
//               //           fit: BoxFit.cover,
//               //           image: NetworkImage(item[index].photo.toString()))),
//               // ),
//               // Text("This is My ex number ${item[index].id.toString()}"),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class Bankbranchlist {
//   Bankbranchlist({
//     this.bankBranchId,
//     this.bankBranchDetailsId,
//     this.bankBranchName,
//     this.bankBrandOfficer,
//     this.bankBrandContact,
//     this.bankBranchProvinceId,
//     this.bankBranchDistrictId,
//     this.bankBranchCommuneId,
//     this.bankBranchVillage,
//     this.bankBranchPublished,
//     this.bankBranchCreatedBy,
//     this.bankBranchCreatedDate,
//     this.bankBranchModifyBy,
//     this.bankBranchModifyDate,
//     this.rememberToken,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String? bankBranchId;
//   String? bankBranchDetailsId;
//   String? bankBranchName;
//   String? bankBrandOfficer;
//   String? bankBrandContact;
//   String? bankBranchProvinceId;
//   String? bankBranchDistrictId;
//   String? bankBranchCommuneId;
//   String? bankBranchVillage;
//   String? bankBranchPublished;
//   dynamic bankBranchCreatedBy;
//   DateTime? bankBranchCreatedDate;
//   dynamic bankBranchModifyBy;
//   dynamic bankBranchModifyDate;
//   dynamic rememberToken;
//   dynamic createdAt;
//   dynamic updatedAt;

//   factory Bankbranchlist.fromJson(Map<String, dynamic> json) => Bankbranchlist(
//         bankBranchId: json["bank_branch_id"],
//         bankBranchDetailsId: json["bank_branch_details_id"],
//         bankBranchName: json["bank_branch_name"],
//         bankBrandOfficer: json["bank_brand_officer"],
//         bankBrandContact: json["bank_brand_contact"],
//         bankBranchProvinceId: json["bank_branch_province_id"],
//         bankBranchDistrictId: json["bank_branch_district_id"],
//         bankBranchCommuneId: json["bank_branch_commune_id"],
//         bankBranchVillage: json["bank_branch_village"],
//         bankBranchPublished: json["bank_branch_published"],
//         bankBranchCreatedBy: json["bank_branch_created_by"],
//         bankBranchCreatedDate: DateTime.parse(json["bank_branch_created_date"]),
//         bankBranchModifyBy: json["bank_branch_modify_by"],
//         bankBranchModifyDate: json["bank_branch_modify_date"],
//         rememberToken: json["remember_token"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bank_branch_id": bankBranchId,
//         "bank_branch_details_id": bankBranchDetailsId,
//         "bank_branch_name": bankBranchName,
//         "bank_brand_officer": bankBrandOfficer,
//         "bank_brand_contact": bankBrandContact,
//         "bank_branch_province_id": bankBranchProvinceId,
//         "bank_branch_district_id": bankBranchDistrictId,
//         "bank_branch_commune_id": bankBranchCommuneId,
//         "bank_branch_village": bankBranchVillage,
//         "bank_branch_published": bankBranchPublished,
//         "bank_branch_created_by": bankBranchCreatedBy,
//         "bank_branch_created_date": bankBranchCreatedDate?.toIso8601String(),
//         "bank_branch_modify_by": bankBranchModifyBy,
//         "bank_branch_modify_date": bankBranchModifyDate,
//         "remember_token": rememberToken,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
