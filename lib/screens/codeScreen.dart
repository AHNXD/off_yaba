import 'dart:async';

import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/routerScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeScreen extends StatefulWidget {
  static const routeName = '/code';
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

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
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 64.0, right: 64.0, top: 64.0, bottom: 16),
                  child: Image.asset("assets/offYaba.png"),
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
                      // obscureText: true,
                      // obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.scale,
                      // validator: (v) {
                      //   if (v!.length < 3) {
                      //     return "I'm from validator";
                      //   } else {
                      //     return null;
                      //   }
                      // },
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
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
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
                        Navigator.pop(context);
                        Navigator.of(context)
                            .push(goRoute(x: const RouterScreen()));
                      },
                      child: Text(
                        lang == "ar" ? "تأكيد" : "Confirm",
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
