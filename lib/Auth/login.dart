// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_print, prefer_is_empty

import 'package:admin/Auth/register.dart';
import 'package:admin/Customs/ProgressHUD.dart';
import 'package:admin/Customs/formVLD.dart';
import 'package:admin/Customs/responsive.dart';
import 'package:admin/Memory/Local_data.dart';
import 'package:admin/model/models/login_model.dart';
import 'package:admin/server/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import '../../components/contants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../interface/homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  late int id = 0;
  late String username = "";
  late String first_name = "";
  late String last_name = "";
  late String email = "";
  late String gender = "";
  late String from = "";
  late String tel = "";
  static List<PeopleModel> list = [];
  static bool status = false;
  PeopleModel? peopleModel;
  late TextEditingController Email;
  late TextEditingController Password;
  selectPeople() async {
    list = await PeopleController().selectPeople();
    if (list.isEmpty) {
      setState(() {
        status = false;
        // print(list[0].name.toString());
        // print("asfdsdfsdfsdsfdsfd");
        // Email = TextEditingController(text: list[0].name);
        // Password = TextEditingController(text: list[0].password);
      });
    } else {
      setState(() {
        status = true;
        Email = TextEditingController(text: list[0].name);
        Password = TextEditingController(text: list[0].password);
      });
    }
  }

  @override
  void initState() {
    selectPeople();
    status;
    list;

    super.initState();
    requestModel = LoginRequestModel(email: "", password: "");
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSteup(context),
    );
  }

  Widget _uiSteup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/New_KFA_Logo.png',
          height: 100,
          width: 140,
        ),
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.blue[300],
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Responsive(
            mobile: login(context),
            tablet: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: login(context),
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
                        child: login(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
            phone: login(context),
          ),
        ),
      ),
    );
  }

  Padding login(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Welcome to KFA system',
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
            // FormValidate(
            //   label: 'Email',
            //   onSaved: (input) => requestModel.email = input!,
            //   iconname: Icon(
            //     Icons.email,
            //     color: kImageColor,
            //   ),
            // ),

            ((status == false) ? input(context) : Output(context)),
            // input(context),
            SizedBox(
              height: 10.0,
            ),
            // ignore: deprecated_member_use
            SizedBox(
              width: 150,
              child: AnimatedButton(
                text: 'Login',
                color: kPrimaryColor,
                pressEvent: () {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    APIservice apIservice = APIservice();
                    apIservice.login(requestModel).then((value) {
                      Load(value.token);
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value.message == "Login Successfully!") {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: false,
                          title: value.message,
                          autoHide: Duration(seconds: 3),
                          onDismissCallback: (type) {
                            // debugPrint('Dialog Dissmiss from callback $type');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    user: username,
                                    email: email,
                                    first_name: first_name,
                                    last_name: last_name,
                                    gender: gender,
                                    from: from,
                                    tel: tel,
                                    id: id.toString(),
                                  ),
                                ));
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

                    print(requestModel.toJson());
                  }
                  if (list.length > 0) {
                    if (list.elementAt(0).name.toString() !=
                        requestModel.email) {
                      var people = PeopleModel(
                        id: 0,
                        name: requestModel.email,
                        password: requestModel.password,
                      );
                      PeopleController().insertPeople(people);
                    }
                  }
                  if (list.length <= 0) {
                    var people = PeopleModel(
                      id: 0,
                      name: requestModel.email,
                      password: requestModel.password,
                    );
                    PeopleController().insertPeople(people);
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "Don't have any account? ",
                style: TextStyle(fontSize: 16.0, color: kTextLightColor),
              ),
              TextSpan(
                text: 'Register',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                style: TextStyle(
                  fontSize: 16.0,
                  color: kImageColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }

  void Load(String token) async {
    setState(() {});
    var rs = await http.get(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);
      setState(() {
        id = jsonData["id"];
        username = jsonData['username'];
        first_name = jsonData['first_name'];
        last_name = jsonData['last_name'];
        email = jsonData['email'];
        gender = jsonData['gender'];
        from = jsonData['known_from'];
        tel = jsonData['tel_num'];
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

  Widget input(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            // controller: Email,
            onSaved: (input) => requestModel.email = input!,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                color: kImageColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(0, 126, 250, 1),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 249, 0, 0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 249, 0, 0),
                ),
                //  borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          //   height: 55,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            // controller: password,
            // initialValue: "list[0].password",
            onSaved: (input) => requestModel.password = input!,
            obscureText: _isObscure,
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
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
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
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget Output(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            controller: Email,
            onSaved: (input) => requestModel.email = input!,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                color: kImageColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(0, 126, 250, 1), width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(0, 126, 250, 1),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 249, 0, 0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 249, 0, 0),
                ),
                //  borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          //   height: 55,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: TextFormField(
            controller: Password,
            // initialValue: "list[0].password",
            onSaved: (input) => requestModel.password = input!,
            obscureText: _isObscure,
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
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
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
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'require *';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
