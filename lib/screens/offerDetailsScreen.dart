import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:off_yaba/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OfferDetailsScreen extends StatelessWidget {
  static const routeName = '/offerDetails';
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: appColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Off ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: [])),
                          TextSpan(
                              text: "Yaba",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))
                        ]),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          )),
                    ],
                  )),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(color: appColor, width: 5),
                                borderRadius: BorderRadius.circular(15)),
                            child: QrImageView(
                              errorStateBuilder: (cxt, err) {
                                return Center(
                                  child: Text(
                                    lang == "ar"
                                        ? "حدث خطأما..."
                                        : 'Uh oh! Something went wrong...',
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                              semanticsLabel:
                                  lang == "ar" ? "تجريب" : "Testing",
                              dataModuleStyle: const QrDataModuleStyle(
                                color: Colors.black,
                              ),
                              eyeStyle: const QrEyeStyle(color: Colors.black),
                              data: lang == "ar" ? "تجريب" : "Testing",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(color: appColor, width: 5),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              lang == "ar" ? "تجريب" : "Testing",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
