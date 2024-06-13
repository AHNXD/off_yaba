import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/employe/employee_scan_screen.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/services/network/auth_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeScreen extends StatefulWidget {
  static const routeName = '/code';
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  // ..text = "123456";

  bool hasError = false;
  String currentText = "";
  bool showError = false;
  String errorMessage = '';
  String code = '';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String userType = arguments['user_type'].toString();
    String authType = arguments["auth_type"].toString();
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        // Set background color
        // backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bg),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 64.0, right: 64.0, top: 64.0, bottom: 16),
                    child: Image.asset("assets/offYaba.png"),
                  ),
                  if (showError)
                    Center(
                      child: Text(
                        errorMessage,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: appColor,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        blinkWhenObscuring: true,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(15),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.grey,
                            inactiveColor: Colors.grey,
                            activeColor: appColor),
                        cursorColor: Colors.black,
                        enableActiveFill: true,
                        onChanged: (value) => code = value,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "الرجاء ادخال الرمز";
                          }
                          if (value.length < 6) {
                            return "الرجاء إكمال الرمز";
                          }
                          return null;
                        },
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: appColor,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16)),
                              onPressed: () {},
                              child: Text(
                                lang == "ar" ? "إعادة ارسال الرمز" : "Confirm",
                                style: const TextStyle(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "cocon-next-arabic"),
                              )),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: appColor,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  log(userType);
                                  log(authType);
                                  Map<String, dynamic> data = {
                                    "code": code,
                                    "phone_number":
                                        "+964" + arguments["phone_number"],
                                    "name": arguments["name"]
                                  };

                                  if (authType == "reg") {
                                    AuthApiService.verifyRegister(data: data)
                                        .then((value) => value.fold((user) {
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                  goRoute(
                                                      x: const RouterScreen()));
                                            }, (failure) {
                                              setState(() {
                                                showError = true;
                                                errorMessage = failure.message!;
                                              });
                                            }))
                                        .onError((error, stackTrace) {
                                      setState(() {
                                        showError = true;
                                        errorMessage =
                                            "لقد حدث خطأ ما يرجى المحاولة لاحقا";
                                      });
                                    });
                                  }
                                  if (authType == "login") {
                                    if (userType == "emp") {
                                      AuthApiService.verifyEmployeeLogin(
                                              code: code,
                                              phoneNumber: data["phone_number"])
                                          .then((value) => value.fold((user) {
                                                Navigator.of(context)
                                                    .pushReplacement(goRoute(
                                                        x: const EmployeeScreen()));
                                              }, (failure) {
                                                setState(() {
                                                  showError = true;
                                                  errorMessage =
                                                      failure.message!;
                                                });
                                              }));
                                    }
                                    if (userType == "user") {
                                      AuthApiService.verifyUserLogin(
                                              code: code,
                                              phoneNumber: data["phone_number"])
                                          .then((value) => value.fold((user) {
                                                Navigator.of(context)
                                                    .pushReplacement(goRoute(
                                                        x: const RouterScreen()));
                                              }, (failure) {
                                                setState(() {
                                                  showError = true;
                                                  errorMessage =
                                                      failure.message!;
                                                });
                                              }));
                                    }
                                  }
                                }
                              },
                              child: Text(
                                lang == "ar" ? "تأكيد" : "Confirm",
                                style: const TextStyle(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "cocon-next-arabic"),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))),
      ),
    );
  }
}
