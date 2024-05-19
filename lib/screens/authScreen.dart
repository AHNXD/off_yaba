// Import libraries
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/signUpScreen.dart';
import 'package:off_yaba/screens/user_type_screen.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/select';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage("assets/background2.png"),
                fit: BoxFit.cover, // convert to cover
              ),
            ),
            child: SafeArea(
                child: ListView(
              children: [
                const SizedBox(height: 32),
                Padding(
                        padding: const EdgeInsets.only(
                            left: 64.0, right: 64.0, top: 64.0, bottom: 16),
                        child: Image.asset("assets/offYaba.png"))
                    .animate()
                    .slide(duration: 1.seconds)
                    .fadeIn(duration: 1.seconds),
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
                                .push(goRoute(x: const PickUserScreen()));
                          },
                          child: Text(
                            lang == "ar" ? "تسجيل دخول" : "Login",
                            style: const TextStyle(
                                color: appColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "cocon-next-arabic"),
                          ))
                      .animate()
                      .slideX(duration: 0.7.seconds)
                      .shimmer(duration: 1.seconds),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 60.0, left: 60, top: 16),
                  child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              backgroundColor: appColor,
                              padding: const EdgeInsets.all(16)),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context)
                                .push(goRoute(x: const SignUpScreen()));
                          },
                          child: Text(
                            lang == "ar" ? "حساب جديد" : "Sign Up",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "cocon-next-arabic"),
                          ))
                      .animate()
                      .slideX(duration: 0.7.seconds)
                      .shimmer(duration: 1.seconds),
                ),
              ],
            ))),
      ),
    );
  }
}
