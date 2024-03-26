// Import libraries
import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Set background color
        backgroundColor: Colors.white,
        body: Scaffold(
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/background.png"),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "off ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "yaba",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ))
                ],
              ))),
        ));
  }
}
