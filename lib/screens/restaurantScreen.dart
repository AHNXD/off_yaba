import 'package:flutter/material.dart';
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
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width / 3,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Text(
                                  "العروض",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.discount,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width / 3,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Text(
                                  "التفاصيل",
                                  style: TextStyle(color: appColor),
                                ),
                                Icon(
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
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "اسم المطعم",
                style: TextStyle(
                    fontFamily: "cocon-next-arabic",
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              const Row(
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
              const Text(
                "النوع",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              const Divider(
                color: appColor,
                thickness: 1.5,
              ),
              const Text(
                "العروض",
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 2.1,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext, index) {
                      return Container(
                        width: double.infinity,
                        height: 150,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: appColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width / 1.5,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/pic1.jpg"),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topLeft: Radius.circular(30)),
                                color: appColor,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(
                              "%$index",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            const SizedBox()
                          ],
                        ),
                      );
                    }),
              )
            ]),
      ),
    );
  }
}
