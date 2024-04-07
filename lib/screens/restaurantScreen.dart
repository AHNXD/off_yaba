import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:off_yaba/constant.dart';

class RestaurantScreen extends StatefulWidget {
  static const routeName = '/restaurant';
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurabtScreenState();
}

class _RestaurabtScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/pic3.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, right: 16, left: 16),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width / 3,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        lang == "ar" ? "العروض" : "Offers",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Icon(
                                        Icons.discount,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width / 3,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        lang == "ar" ? "التفاصيل" : "Details",
                                        style: const TextStyle(color: appColor),
                                      ),
                                      const Icon(
                                        Icons.info,
                                        color: appColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Text(
                                textAlign: TextAlign.center,
                                lang == "ar" ? "اسم المطعم" : "Restaurant Name",
                                style: const TextStyle(
                                    fontFamily: "cocon-next-arabic",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      color: appColor,
                    ),
                    const Text(
                      "0.6",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      lang == "ar" ? "كم" : "km",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  lang == "ar" ? "النوع" : "Type",
                  style: const TextStyle(color: Colors.grey, fontSize: 25),
                ),
                const Divider(
                  color: appColor,
                  thickness: 1.5,
                ),
                Text(
                  lang == "ar" ? "العروض" : "Offers",
                  style: const TextStyle(color: Colors.grey, fontSize: 25),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.9,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext, index) {
                        return Container(
                          width: double.infinity,
                          height: 150,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: appColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Text(
                                "%${index + 1}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            bottomRight: Radius.circular(50))),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50))),
                                  )
                                ],
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width / 1.5,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/pic1.jpg"),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: appColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ]),
        ),
      ),
    );
  }
}
