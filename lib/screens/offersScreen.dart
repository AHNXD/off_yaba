import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
            margin: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
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
                const SizedBox(
                  height: 8,
                ),
              ],
            )),
        SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              primary: true,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height - 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (BuildContext, index) {
                        return Container(
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: appColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                  ),
                                  Icon(
                                    Icons.qr_code_2,
                                    color: Colors.black,
                                    size: 80,
                                  ),
                                ],
                              ),
                              Text(
                                lang == "ar" ? "انقر للعرض" : "Tap to show",
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: "cocon-next-arabic"),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
