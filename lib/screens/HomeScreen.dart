import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/categoriesScreen.dart';
import 'package:off_yaba/screens/restaurantScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
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
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Text(
                        "الأقسام",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, CategoriesScreen.routeName);
                          },
                          icon: const Icon(Icons.category_outlined,
                              color: appColor)),
                      const SizedBox(
                        height: 32,
                        child: Expanded(
                          child: VerticalDivider(
                            thickness: 2,
                            width: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "البحث",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
        SizedBox(
          height: MediaQuery.sizeOf(context).height - 250,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "المزيد",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text("اقوى التخفيضات",
                        style: TextStyle(
                            fontFamily: "cocon-next-arabic",
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 50,
                      itemBuilder: (BuildContext, index) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/logo1.jpg"),
                                  backgroundColor: appColor,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text("اسم المطعم"),
                            ],
                          ),
                        );
                      }),
                ),
                const Divider(
                  thickness: 2,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text("التخفيضات القريبة منك",
                      style: TextStyle(
                          fontFamily: "cocon-next-arabic",
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext, index) {
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "كم",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "0.6",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.pin_drop,
                                    color: appColor,
                                  )
                                ],
                              ),
                              Text("اسم المطعم",
                                  style: TextStyle(
                                      fontFamily: "cocon-next-arabic",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "النوع",
                              style: TextStyle(color: Colors.grey),
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
        )
      ],
    );
  }
}
