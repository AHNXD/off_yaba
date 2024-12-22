import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/services/network/cart_service.dart';

class OrderItemDeatils extends StatefulWidget {
  static String routeName = '/order-item-details';
  const OrderItemDeatils({super.key});

  @override
  State<OrderItemDeatils> createState() => _OrderItemDeatilsState();
}

class _OrderItemDeatilsState extends State<OrderItemDeatils> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    StoreOfferModel offer = arguments['offer'];
    return Scaffold(
      bottomNavigationBar: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          shape: const BeveledRectangleBorder(),
          minimumSize: const Size.fromHeight(kToolbarHeight),
          maximumSize: const Size.fromHeight(kToolbarHeight),
        ),
        onPressed: offer.itemCount == 0
            ? null
            : () {
                CartService.addItemToCart(
                        itemId: offer.id!,
                        itemCount: offer.itemCount,
                        extra_notes: offer.name)
                    .then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تمت الإضافة للسلة بنجاح"),
                      ),
                    );
                    Navigator.pop(context);
                    return;
                  },
                );
              },
        label: const Text(
          "إضافة الى السلة",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    offer.image!,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: appColor,
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                offer.name!,
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   offer.body!,
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyMedium!
              //       .copyWith(color: Colors.grey.shade600),
              // ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "تعليمات خاصة",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: "إذا كان لديك أي ملاحظات يرجى كتابتها هنا",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          offer.itemCount++;
                          setState(() {});
                        },
                        icon: const Icon(
                          CupertinoIcons.add,
                          size: 20,
                        ),
                        color: Colors.white,
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                      ),
                      Text(
                        offer.itemCount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: offer.itemCount == 0
                            ? null
                            : () async {
                                setState(() {
                                  offer.itemCount--;
                                });
                              },
                        icon: const Icon(
                          CupertinoIcons.minus,
                          size: 20,
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
