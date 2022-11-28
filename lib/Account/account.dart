// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:admin/Auth/login.dart';
import 'package:admin/Profile/components/TwinBox.dart';
import 'package:admin/Profile/components/Drop.dart';
import 'package:admin/Profile/components/Drop_down.dart';
import 'package:admin/contants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Profile/components/Drop_down.dart';
import '../Profile/components/FieldBox.dart';
import '../components/bank.dart';

class Account extends StatefulWidget {
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  const Account({
    Key? key,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
//update data from api
  String url = "https://kfahrm.cc/Laravel/public/api/users";

//get image and crop
  String? _imagepath;
  File? _imagefile;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  var bank = [
    'Bank',
    'Private',
    'Other',
  ];

  getImage(ImageSource source) async {
    _imagefile = (await _picker.getImage(source: source)) as File?;
    if (_imagefile != null) {
      CroppedFile? cropped = await _cropper.cropImage(
        sourcePath: _imagefile!.path,
        //aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 90,
        maxHeight: 100,
        maxWidth: 100,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      setState(() {
        _imagefile = cropped as File?;
      });
    } else {
      throw "Could not cropped Image";
    }
  }

//function LogOut
  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Fluttertoast.showToast(
      msg: 'Log Out',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.blue,
      fontSize: 20,
    );
    Get.off(() => Login());
  }

  @override
  Widget build(BuildContext context) {
    //controller to update dataInfo
    final controller = TextEditingController(text: widget.username);
    //Get.lazyPut(() => ImageController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 20),
            // constraints: BoxConstraints(
            //   maxWidth: double.infinity,
            //   maxHeight: 750,
            // ),
            //padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //---Profile---//
              children: [
                Column(
                  children: [
                    Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.black38,
                            child: CircleAvatar(
                                radius: 68,
                                backgroundColor: Colors.blue,
                                backgroundImage: AssetImage(
                                    "assets/images/Real Estate Award 2019.jpg"))),
                        kWidthSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // controller: controller,
                              widget.username,

                              //widget.username,
                              //style: Theme.of(context).textTheme.subtitle1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.id.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        TwinBox(
                          labelText1: 'Firstname',
                          labelText2: 'Lastname',
                          fname: widget.first_name,
                          lname: widget.last_name,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Dropdown(
                              gender: widget.gender,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SizedBox(
                              height: 59,
                              width: 140,
                              child: DropdownButtonFormField<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    // ignore: avoid_print
                                    print(newValue);
                                  });
                                },
                                // validator: (String? value) {
                                //   if (value?.isEmpty ?? true) {
                                //     return 'Please select bank';
                                //   }
                                //   return null;
                                // },
                                value: widget.from,
                                items: bank
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                                // add extra sugar..
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: kImageColor,
                                ),

                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: 'Bank',
                                  hintText: 'Select',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 60,
                          width: 280,
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: TextFormField(
                            initialValue: widget.tel,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              filled: true,
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Field_box(
                          name: 'email',
                          email: widget.email,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Field_box(
                          name: ' address',
                          email: widget.email,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Save Change'),
                            onPressed: () {
                              logOut();
                            },
                          ),
                          SizedBox(width: 15),
                          ElevatedButton(
                            child: Text('Log Out'),
                            onPressed: () {
                              logOut();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                // Column(
                //   children: [

                //   ],
                // ),
              ],
            )

            // ignore: deprecated_member_use
            ),
      ),
    );
  }
}

class EditPicture extends StatelessWidget {
  final String title;
  final icon;
  final press;
  const EditPicture({
    Key? key,
    required this.title,
    required this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        InkWell(
          onTap: press,
          splashColor: Colors.lightBlue,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  icon,
                  color: kImageColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// UpdateUserInfo()async{
//   var username =
// }
