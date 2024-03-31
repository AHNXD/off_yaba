import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/routerScreen.dart';
import 'package:pinput/pinput.dart';

class CodeScreen extends StatefulWidget {
  static const routeName = '/code';
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: appColor, width: 3),
      borderRadius: BorderRadius.circular(20),
    ),
  );

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
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    // validator: (s) {
                    //   return s == '2222' ? null : lang == "ar" ? 'الرمز غير صحيح' : 'Pin is incorrect';
                    // },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
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
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ))),
      ),
    );
  }
}
