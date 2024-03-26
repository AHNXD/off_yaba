// Import libraries
import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class Select extends StatelessWidget {
  static const routeName = '/select';
  const Select({super.key});

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
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset("assets/offYaba.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: appColor,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(32)),
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: appColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.white,
                            backgroundColor: appColor,
                            padding: const EdgeInsets.all(32)),
                        onPressed: () {},
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ))),
        ));
  }
}
