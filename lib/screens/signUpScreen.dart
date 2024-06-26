import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/codeScreen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';
  const SignUpScreen({super.key});

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
                fit: BoxFit.fill,
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
                Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 32, right: 32),
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
                    child: TextField(
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
                    textDirection: TextDirection.ltr,
                    child: IntlPhoneField(
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
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
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
                        isLogin = true;
                        Navigator.pop(context);
                        Navigator.of(context)
                            .push(goRoute(x: const CodeScreen()));
                      },
                      child: Text(
                        lang == "ar" ? "حساب جديد" : "Sign Up",
                        style: const TextStyle(
                            color: appColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "cocon-next-arabic"),
                      )),
                ),
              ],
            ))),
      ),
    );
  }
}
