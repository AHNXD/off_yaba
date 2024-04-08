import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/restaurantScreen.dart';

class ShowCategoryScreen extends StatefulWidget {
  static const routeName = '/showCategory';
  const ShowCategoryScreen({super.key});

  @override
  State<ShowCategoryScreen> createState() => _ShowCategoryScreenState();
}

class _ShowCategoryScreenState extends State<ShowCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
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
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BC, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RestaurantScreen.routeName);
                                  },
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(16),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/pic2.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        lang == "ar"
                                            ? "اسم المطعم"
                                            : "Restaurant Name",
                                        style: const TextStyle(
                                            fontFamily: "cocon-next-arabic",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
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
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: lang == "ar"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Text(
                                    lang == "ar" ? "النوع" : "Type",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                                const Divider(
                                  color: appColor,
                                )
                              ],
                            );
                          })),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
