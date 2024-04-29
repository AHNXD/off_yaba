import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/services/network/stores_service.dart';

class RestaurantScreen extends StatefulWidget {
  static const routeName = '/restaurant';
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurabtScreenState();
}

class _RestaurabtScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StoreModel store = arguments['store'];
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(store.image!),
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
                              // lang == "ar" ? "اسم المطعم" : "Restaurant Name",
                              store.name!,
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
                  Text(
                    store.distance!.round().toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    lang == "ar" ? "كم" : "km",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Text(
                // lang == "ar" ? "النوع" : "Type",
                store.section!.name!,
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
              Expanded(
                child: SizedBox(
                  child: FutureBuilder(
                      future: StoreService.getStoreOffers(storeId: store.id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<StoreOfferModel> offers = snapshot.data!;
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("لا يوجد عروض بعد."),
                            );
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: offers.length,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "%${offers[index].discount.toString()}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
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
                                                    bottomLeft:
                                                        Radius.circular(50),
                                                    bottomRight:
                                                        Radius.circular(50))),
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
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50))),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                1.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                offers[index].image!),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          color: appColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
