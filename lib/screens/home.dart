import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.qr_code, size: 30, color: Colors.white),
          Icon(Icons.card_giftcard, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        color: appColor,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      // Set background color
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_2,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              )),
                        ],
                      )
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
                            offset: const Offset(
                                0, 1), // changes position of shadow
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.category_outlined, color: appColor),
                        ),
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CircleAvatar(
                                    backgroundImage: const AssetImage(
                                        "assets/images/logo1.jpg"),
                                    backgroundColor: appColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const Text("اسم المطعم"),
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
                      itemCount: 50,
                      itemBuilder: (BuildContext, index) {
                        return Column(
                          children: [
                            Container(
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
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "كم",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const Text(
                                      "0.6",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Icon(
                                      Icons.pin_drop,
                                      color: appColor,
                                    )
                                  ],
                                ),
                                const Text("اسم المطعم",
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
                            Divider(
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
      )),
    );
  }
}
