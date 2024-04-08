import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/categoriesScreen.dart';
import 'package:off_yaba/screens/restaurantScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding:
                const EdgeInsets.only(left: 32, right: 32, bottom: 16, top: 16),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                        )),
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
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: lang == "ar" ? "البحث" : "Search",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                        child: VerticalDivider(
                          thickness: 2,
                          width: 16,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, CategoriesScreen.routeName);
                          },
                          icon: const Icon(Icons.category_outlined,
                              color: appColor)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CategoriesScreen.routeName);
                        },
                        child: Text(
                          lang == "ar" ? "الأقسام" : "Categories",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(32),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/pic1.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lang == "ar" ? "اقوى التخفيضات" : "Best Deals",
                          style: const TextStyle(
                              fontFamily: "cocon-next-arabic",
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text(
                        lang == "ar" ? "المزيد" : "More",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 50,
                        itemBuilder: (BC2, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RestaurantScreen.routeName);
                                    },
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/images/logo1.jpg"),
                                      backgroundColor: appColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(lang == "ar"
                                    ? "اسم المطعم"
                                    : "Restaurant Name"),
                              ],
                            ),
                          );
                        }),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Align(
                    alignment: lang == "ar"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                        lang == "ar"
                            ? "التخفيضات القريبة منك"
                            : "Best Deals Near you",
                        style: const TextStyle(
                            fontFamily: "cocon-next-arabic",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/pic2.jpg"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      style:
                                          const TextStyle(color: Colors.grey),
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
                      })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
