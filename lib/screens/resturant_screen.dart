import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/cart_model.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/models/store_details_model.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/screens/confirm_order_screen.dart';
import 'package:off_yaba/services/network/cart_service.dart';
import 'package:off_yaba/services/network/clothing_service.dart';
import 'package:off_yaba/services/network/stores_service.dart';
import 'package:off_yaba/widgets/clothing_item_card.dart';
import 'package:off_yaba/widgets/details_list_tile.dart';
import 'package:off_yaba/widgets/offer_card.dart';

class RestaurantScreen extends StatefulWidget {
  static const routeName = '/restaurant';
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurabtScreenState();
}

class _RestaurabtScreenState extends State<RestaurantScreen> {
  bool showDetails = false;
  StoreDetailsModel? storeDetails;
  CartModel? cart;

  Future<bool> _onWillPop() async {
    if (cart?.items != null && cart!.items!.isNotEmpty) {
      return (await showDialog(
          context: context,
          builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: const Text("سيتم حذف الأصناف"),
                  content:
                      const Text("هل أنت متأكد انك تريد الخروج من الصفحة ؟"),
                  actionsAlignment: MainAxisAlignment.spaceAround,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        CartService.clearCart().then((value) {
                          Navigator.of(context).pop(true);
                        });
                      },
                      child: const Text("موافق"),
                    ),
                  ],
                ),
              )));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StoreModel store = arguments['store'];
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: FutureBuilder<CartModel?>(
            future: CartService.getCart(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                cart = snapshot.data!;
                print("cart${cart!.items}");
                if (cart!.items != null && cart!.items!.isNotEmpty) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: const BeveledRectangleBorder(),
                        minimumSize: const Size.fromHeight(kToolbarHeight),
                        maximumSize: const Size.fromHeight(kToolbarHeight),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ConfirmOrderScreen.routeName);
                      },
                      child: const Text(
                        "عرض السلة",
                        style: TextStyle(color: Colors.white),
                      ));
                }
              }
              if (snapshot.hasError) {
                print("cart error: ${snapshot.error}");
              }
              return const SizedBox();
            },
          ),
          body: ListView(shrinkWrap: false, children: [
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
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColor,
                        ),
                        child: const Directionality(
                          textDirection: TextDirection.ltr,
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                                    color:
                                        showDetails ? Colors.white : appColor,
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
                                      color: !showDetails
                                          ? Colors.white
                                          : appColor,
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
                                    color:
                                        !showDetails ? Colors.white : appColor,
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
                            store.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
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
                style: const TextStyle(color: Colors.grey, fontSize: 15),
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
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                if (store.section!.name == "ملابس")
                  FutureBuilder<List<ClothingItemModel>>(
                    future: ClothingService.getClothingItemsByStore(store.id!),
                    builder: (context, snapshot) {
                      print("data: ${snapshot.data.toString()}");
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error: ${snapshot.stackTrace}'));
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: appColor,
                          ),
                        );
                      }
                      var items = snapshot.data!;
                      print('items: $items');

                      return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(context),
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.48,
                        ),
                        itemBuilder: (context, index) => ClothingItemCard(
                          clothingItem: items[index],
                        ),
                      );
                    },
                  ),
                if (store.section!.name != "ملابس")
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
                          print('Offers: $offers');
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: offers.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: appColor,
                                    ),
                                itemBuilder: (context, index) {
                                  return OfferCard(offer: offers[index]);
                                }),
                          );
                        }
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      }),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) return 4;
    if (screenWidth >= 800) return 3;
    return 2;
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
                      if (details.workHours!.isNotEmpty)
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
