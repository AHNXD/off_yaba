import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/code_screen.dart';
import 'package:off_yaba/services/network/auth_service.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  int value = 1;

  TextEditingController phoneController = TextEditingController();
  String countryCode = '964';
  bool showError = false;

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String userType = arguments['user_type'].toString();
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
                child: ListView(
              children: [
                const SizedBox(height: 16),
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
                  padding: const EdgeInsets.all(8),
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
                    child: IntlPhoneField(
                      controller: phoneController,
                      disableLengthCheck: true,
                      languageCode: lang,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: lang == "ar" ? "رقم الهاتف" : "Phone Number",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide(style: BorderStyle.solid)),
                      ),
                      initialCountryCode: 'IQ',
                      onCountryChanged: (value) => setState(() {
                        countryCode = value.fullCountryCode;
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 60.0, left: 60, top: 32, bottom: 16),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: appColor,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(16)),
                      onPressed: () {
                        print(userType);
                        if (userType == "emp") {
                          AuthApiService.loginEmployee(
                                  phoneNumber:
                                      "+$countryCode${phoneController.text}")
                              .then((value) => value.fold((l) {
                                    Navigator.pop(context);
                                    Navigator.of(context).pushNamed(
                                        CodeScreen.routeName,
                                        arguments: {
                                          "user_type": userType,
                                          "auth_type": "login",
                                          "phone_number":
                                              "+$countryCode${phoneController.text}"
                                        });
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
                          return;
                        }
                        AuthApiService.loginUser(
                                phoneNumber: phoneController.text)
                            .then((value) => value.fold((l) {
                                  Navigator.of(context).pushReplacementNamed(
                                      CodeScreen.routeName,
                                      arguments: {
                                        "user_type": userType,
                                        "auth_type": "login",
                                        "phone_number": phoneController.text,
                                      });
                                }, (failure) {
                                  setState(() {
                                    showError = true;
                                    errorMessage = failure.message!;
                                  });
                                }))
                            .onError((error, stackTrace) {
                          setState(() {
                            showError = true;
                            errorMessage = "لقد حدث خطأ ما يرجى المحاولة لاحقا";
                          });
                        });
                        return;
                      },
                      child: Text(
                        lang == "ar" ? "تسجيل دخول" : "Login",
                        style: const TextStyle(
                          color: appColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "cocon-next-arabic",
                        ),
                      )),
                ),
              ],
            ))),
      ),
    );
  }
}
