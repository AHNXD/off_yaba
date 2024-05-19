import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_details_model.dart';
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
  bool showDetails = false;
  StoreDetailsModel? storeDetails;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StoreModel store = arguments['store'];

    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(shrinkWrap: true, children: [
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
                    padding:
                        const EdgeInsets.only(top: 32.0, right: 16, left: 16),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              showDetails = false;
                            }),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width / 3,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                  color: showDetails ? Colors.white : appColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Text(
                                    lang == "ar" ? "العروض" : "Offers",
                                    style: TextStyle(
                                        color: !showDetails
                                            ? Colors.white
                                            : appColor),
                                  ),
                                  Icon(
                                    Icons.discount,
                                    color:
                                        !showDetails ? Colors.white : appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showDetails = true;
                              });
                              _showDetailsBottomSheet(context, store)
                                  .then((value) => setState(() {
                                        showDetails = false;
                                      }));
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width / 3,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                  color: !showDetails ? Colors.white : appColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(),
                                  Text(
                                    lang == "ar" ? "التفاصيل" : "Details",
                                    style: TextStyle(
                                        color: showDetails
                                            ? Colors.white
                                            : appColor),
                                  ),
                                  Icon(
                                    Icons.info,
                                    color:
                                        showDetails ? Colors.white : appColor,
                                  )
                                ],
                              ),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
          Center(
            child: Text(
              // lang == "ar" ? "النوع" : "Type",
              store.section!.name!,
              style: const TextStyle(color: Colors.grey, fontSize: 25),
            ),
          ),
          const Divider(
            color: appColor,
            thickness: 1.5,
          ),
          Column(
            children: [
              Center(
                child: Text(
                  lang == "ar" ? "العروض" : "Offers",
                  style: const TextStyle(color: Colors.grey, fontSize: 25),
                ),
              ),
              FutureBuilder(
                  future: StoreService.getStoreOffers(storeId: store.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Center(
                          child: Text(
                            "لا يوجد عروض بعد.",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List<StoreOfferModel> offers = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                                                bottomLeft: Radius.circular(50),
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
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50))),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(offers[index].image!),
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
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  }),
            ],
          ),
        ]),
      ),
    );
  }

  Future<dynamic> _showDetailsBottomSheet(
      BuildContext context, StoreModel store) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: const BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "التفاصيل",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          FutureBuilder<StoreDetailsModel>(
              future: StoreService.getStoreDetails(storeId: store.id!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("لقد حدث خطأ ما يرجى إعادة المحاولة لاحقا."),
                  );
                }
                if (snapshot.hasData) {
                  StoreDetailsModel details = snapshot.data!;

                  return Column(
                    children: [
                      DetailsListTile(
                          title: "العنوان",
                          value: details.store!.address!,
                          icon: Icons.map),
                      DetailsListTile(
                          title: "المسافة",
                          value: details.store!.distance!.round().toString(),
                          icon: Icons.location_on_outlined),
                      DetailsListTile(
                          title: "النوع",
                          value: details.store!.section!.name!,
                          icon: Icons.category),
                      DetailsListTile(
                          title: "ساعات العمل",
                          value:
                              "${details.workHours!.first.day!} - ${details.workHours!.last.day}",
                          icon: Icons.map),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }
}

class DetailsListTile extends StatelessWidget {
  const DetailsListTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: appColor),
          ),
          Icon(
            icon,
            color: appColor,
          ),
        ],
      ),
    );
  }
}
