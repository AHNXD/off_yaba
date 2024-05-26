import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/signIn_screen.dart';
import 'package:off_yaba/screens/signup_screen.dart';
import 'package:off_yaba/widgets/circular_button.dart';

class PickUserScreen extends StatelessWidget {
  const PickUserScreen({super.key});

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
                image: AssetImage("assets/background-u-type.png"),
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
                  child: Image.asset("assets/offYaba.png"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                    child: Text(
                  "اختر نوع الحساب",
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularButtonWithTitle(
                      backgroundColor: appColor,
                      title: "صاحب مشروع",
                      icon: Icon(
                        Icons.storefront,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.099,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(SignInScreen.routeName,
                            arguments: {"user_type": "emp"});
                      },
                    ),
                    CircularButtonWithTitle(
                      backgroundColor: appColor,
                      title: "مستخدم",
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.099,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(SignInScreen.routeName,
                            arguments: {"user_type": "user"});
                      },
                    ),
                  ],
                ),
              ],
            ))),
      ),
    );
  }
}
