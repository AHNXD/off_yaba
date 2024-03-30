import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/codeScreen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/signin';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Set background color
        backgroundColor: Colors.white,
        body: Scaffold(
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
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset("assets/offYaba.png"),
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
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        hintText: "9xxxxxxxx",
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
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
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 60.0, left: 60, top: 32, bottom: 16),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: appColor,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(16)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(goRoute(x: const CodeScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: appColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ))),
        ));
    ;
  }
}
