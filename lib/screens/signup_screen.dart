import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/code_screen.dart';
import 'package:off_yaba/screens/signIn_screen.dart';
import 'package:off_yaba/services/network/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool showError = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        // Set background color
        backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 96.0, right: 96.0, top: 96.0, bottom: 16),
                    child: Image.asset("assets/offYaba.png"),
                  ),
                  if (showError)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        child: Text(
                          errorMessage,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 32, right: 32),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: appColor,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "هذا الحقل مطلوب";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: appColor,
                          ),
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText:
                              lang == "ar" ? "أدخل الإسم" : "Enter your name",
                          label: Text(lang == "ar" ? "الأسم" : "Name"),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 32, right: 32, top: 16),
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
                      textDirection: TextDirection.rtl,
                      child: IntlPhoneField(
                        controller: phoneController,
                        disableLengthCheck: true,
                        languageCode: lang,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelText:
                              lang == "ar" ? "رقم الهاتف" : "Phone Number",
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              borderSide: BorderSide(style: BorderStyle.solid)),
                        ),
                        initialCountryCode: 'IQ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 60.0, left: 60, top: 16, bottom: 32),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: appColor,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(16)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthApiService.register(
                              name: nameController.text,
                              phone: phoneController.text,
                            ).then((value) {
                              value.fold((l) {
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(
                                    CodeScreen.routeName,
                                    arguments: {
                                      "user_type": "user",
                                      "auth_type": "reg",
                                      "phone_number": phoneController.text,
                                      "name": nameController.text,
                                    });
                                return;
                              }, (failure) {
                                if (failure.statusCode == 400) {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushNamed(
                                      SignInScreen.routeName,
                                      arguments: {"user_type": "user"});
                                  return;
                                }
                                setState(() {
                                  showError = true;
                                  errorMessage = failure.message!;
                                });
                              });
                            }).onError((error, stackTrace) {
                              setState(() {
                                showError = true;
                                errorMessage =
                                    "لقد حدث خطأ ما يرجى المحاولة لاحقا";
                              });
                            });
                          }
                        },
                        child: Text(
                          lang == "ar" ? "حساب جديد" : "Sign Up",
                          style: const TextStyle(
                            color: appColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "cocon-next-arabic",
                          ),
                        )),
                  ),
                ],
              ),
            ))),
      ),
    );
  }
}
