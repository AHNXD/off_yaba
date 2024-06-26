import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/screens/categoriesScreen.dart';
import 'package:off_yaba/screens/restaurantScreen.dart';
import 'package:off_yaba/services/network/stores_service.dart';
import 'package:off_yaba/widgets/store_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          onChanged: (value) {
                            // showSearch(context: context, delegate:);
                          },
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
                    child: FutureBuilder<List<StoreModel>?>(
                        future: StoreService.getStoresWithBestOffers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<StoreModel> stores = snapshot.data!;
                            print(stores);
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: stores.length,
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
                                              Navigator.pushNamed(context,
                                                  RestaurantScreen.routeName,
                                                  arguments: {
                                                    "store": stores[index]
                                                  });
                                            },
                                            child: stores[index].image == null
                                                ? const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        "assets/images/no-image-found.png"),
                                                    backgroundColor: appColor,
                                                  )
                                                : CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            stores[index]
                                                                .image!),
                                                    backgroundColor: appColor,
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            stores[index].name!,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        // Text(lang == "ar"
                                        //     ? "اسم المطعم"
                                        //     : "Restaurant Name"),
                                      ],
                                    ),
                                  );
                                });
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
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
                  FutureBuilder<List<StoreModel>?>(
                      future: StoreService.getStoresByCoords(
                          page: 1, longitude: 33, latitude: 30),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Container(
                            color: Colors.red,
                            child: const Text("حدث خطأ يرجى المحاولة مرة أخرى"),
                          );
                        }
                        if (snapshot.hasData) {
                          List<StoreModel> stores = snapshot.data!;

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BC, index) {
                                return StoreCard(store: stores[index]);
                              });
                        }

                        return const Center(child: CircularProgressIndicator());
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
