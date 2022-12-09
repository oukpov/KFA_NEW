// ignore_for_file: prefer_const_constructors

import 'package:admin/Customs/ProgressHUD.dart';
import 'package:admin/Customs/formTwin.dart';
import 'package:admin/components/contants.dart';
import 'package:admin/model/models/register_model.dart';
import 'package:admin/respon.dart';
import 'package:admin/server/api_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Customs/formVLD.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Register();
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fromValue = 'Bank';
  String genderValue = 'Female';
  // List of items in our dropdown menu
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
  bool _isObscure = true;
  late RegisterRequestModel requestModel;
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_new
    requestModel = new RegisterRequestModel(
      email: "",
      password: "",
      first_name: '',
      gender: '',
      known_from: '',
      last_name: '',
      tel_num: '',
      username: '',
      password_confirmation: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSteup(context),
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSteup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/KFA-Logo.png',
          height: 100,
          width: 130,
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: kPrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Responsive(
            mobile: register(context),
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: register(context),
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
                        width: 500,
                        child: register(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
            phone: register(context),
          ),
        ),
      ),
    );
  }

  Padding register(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Register to KFA system',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text.rich(
              TextSpan(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  TextSpan(
                    text: "ONE CLICK ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kImageColor,
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
            SizedBox(
              height: 30.0,
            ),
            FormTwin(
                Label1: 'First Name',
                Label2: 'Last Name',
                onSaved1: (input) => requestModel.first_name = input!,
                onSaved2: (input) => requestModel.last_name = input!,
                icon1: Icon(
                  Icons.person,
                  color: kImageColor,
                ),
                icon2: Icon(
                  Icons.person,
                  color: kImageColor,
                )),
            SizedBox(
              height: 10,
            ),
            FormValidate(
                onSaved: (input) => requestModel.username = input!,
                label: 'Username',
                iconname: Icon(
                  Icons.person,
                  color: kImageColor,
                )),
            SizedBox(
              height: 10,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 60,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: DropdownButtonFormField<String>(
                  //value: genderValue,
                  onSaved: (input) => requestModel.gender = input!,
                  onChanged: (String? newValue) {
                    setState(() {
                      genderValue = newValue!;
                      // ignore: avoid_print
                      print(newValue);
                    });
                  },
                  items: gender
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
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
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'Gender',
                    hintText: 'Select one',
                    prefixIcon: Icon(
                      Icons.accessibility_new_sharp,
                      color: kImageColor,
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
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormValidate(
              onSaved: (input) => requestModel.email = input!,
              label: 'Email',
              iconname: Icon(
                Icons.email,
                color: kImageColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormValidate(
              onSaved: (input) => requestModel.tel_num = input!,
              label: 'Phone Number',
              iconname: Icon(
                Icons.phone,
                color: kImageColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                obscureText: _isObscure,
                onSaved: (input) => requestModel.password = input!,
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  labelText: 'Enter password',
                  prefixIcon: Icon(
                    Icons.key,
                    color: kImageColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: kImageColor,
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
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
                      width: 2,
                      color: kerror,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'require *';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                obscureText: _isObscure,
                onSaved: (input) => requestModel.password_confirmation = input!,
                decoration: InputDecoration(
                  fillColor: kwhite,
                  filled: true,
                  labelText: 'Confirm password',
                  prefixIcon: Icon(
                    Icons.key,
                    color: kImageColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: kImageColor,
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2.0),
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
                      width: 2,
                      color: kerror,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kPrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'require *';
                  }
                  return null;
                },
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 70,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: DropdownButtonFormField<String>(
                  //value: fromValue,
                  onSaved: (input) => requestModel.known_from = input!,
                  onChanged: (String? newValue) {
                    setState(() {
                      fromValue = newValue!;
                      // ignore: avoid_print
                      print(newValue);
                    });
                  },
                  items: from
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
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
                    fillColor: kwhite,
                    filled: true,
                    labelText: 'From',
                    hintText: 'Select one',
                    prefixIcon: Icon(
                      Icons.business_outlined,
                      color: kImageColor,
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
                        width: 2,
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
            ),

            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 150,
              child: AnimatedButton(
                text: 'Register',
                color: kPrimaryColor,
                pressEvent: () {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    APIservice apIservice = APIservice();
                    apIservice.register(requestModel).then((value) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value.message == "User successfully registered") {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: false,
                          title: value.message,
                          autoHide: Duration(seconds: 3),
                          onDismissCallback: (type) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                        ).show();
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
                    });
                    // ignore: avoid_print
                    print(requestModel.toJson());
                  }
                },
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Already have account? ",
                    style: TextStyle(fontSize: 16.0, color: kTextLightColor),
                  ),
                  TextSpan(
                    text: 'Log In',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kImageColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
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
