// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/cart_model.dart';
import 'package:off_yaba/models/code_scanner_model.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/services/network/cart_service.dart';
import 'package:off_yaba/services/network/qr_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

import '../services/location_service.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static String routeName = '/confirm-order';
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  CartModel? cart;
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  int? selectedQrCode;
  String? long = null;
  String? lat = null;
  @override
  void initState() {
    super.initState();
    CartService.getCart().then((value) => setState(() {
          cart = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          shape: const BeveledRectangleBorder(),
          minimumSize: const Size.fromHeight(kToolbarHeight),
          maximumSize: const Size.fromHeight(kToolbarHeight),
        ),
        onPressed: () async {
          if (long == null && lat == null) {
            await getLocation(context);
          }
          if (location.text.isNotEmpty && phone.text.isNotEmpty) {
            CartService.checkoutCart(
              location: location.text,
              phone: phone.text,
              code_id: selectedQrCode,
              latitude: lat!,
              longitude: long!,
            ).then(
              (value) {
                showSnakBar(
                    context: context,
                    color: Colors.green,
                    msg: "تمت عملية الطلب بنجاح");
                Navigator.of(context)
                    .pushReplacementNamed(RouterScreen.routeName);
              },
            );
          } else {
            showSnakBar(
                context: context,
                color: Colors.red,
                msg: "قم بتحديد جميع البيانات");
          }
        },
        child: const Text(
          "تأكيد الطلب",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(
                  backArrow: true,
                ),
                if (cart != null)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      itemCount: cart!.items!.length,
                      itemBuilder: (context, index) => OrderItemTile(
                        leading: Text(
                          cart!.items![index].quantity.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: appColor, fontWeight: FontWeight.bold),
                        ),
                        titleText: cart!.items![index].item!.name!,
                        trailingText:
                            '${cart!.items![index].item!.price! * cart!.items![index].quantity!}د.ع',
                      ),
                    ),
                    // child: FutureBuilder(
                    //   future: CartService.getCart(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Center(
                    //         child: Text('Error: ${snapshot.error}'),
                    //       );
                    //     } else if (!snapshot.hasData ||
                    //         snapshot.data!.items!.isEmpty) {
                    //       return const Center(
                    //         child: Text('No items in the cart'),
                    //       );
                    //     } else {
                    //       setState(() {
                    //         cart = snapshot.data;
                    //       });
                    //       return
                    //     }
                    //   },
                    // ),
                  ),
                const OrderItemTile(
                    leading: Icon(
                      Icons.bike_scooter,
                      color: appColor,
                    ),
                    titleText: "كلفة التوصيل",
                    trailingText: "2000د.ع"),
                if (cart != null)
                  OrderItemTile(
                      leading: const Icon(
                        Icons.attach_money_sharp,
                        color: appColor,
                      ),
                      titleText: "المبلغ الكلي",
                      trailingText: "${cart!.total! + 2000}د.ع"),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: location,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "العنوان بالكامل",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                        icon: const Icon(
                          Icons.pin_drop_outlined,
                          color: Colors.blue,
                          size: 35,
                        ),
                        onPressed: () async {
                          await getLocation(context);
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    hintText: "رقم الجوال",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const OrderItemTile(
                    leading: Icon(
                      Icons.qr_code,
                      color: appColor,
                    ),
                    titleText: "اختر كوبون:",
                    trailingText: ""),
                FutureBuilder(
                  future: QRService.getUserCodes(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('لا يوجد كوبونات صالحة');
                      // return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<CodeScannerModel> validQrCodes =
                          snapshot.data!.where((qrCode) {
                        print(qrCode.toString());
                        return qrCode.isValid! as bool;
                      }).toList();

                      if (validQrCodes.isEmpty) {
                        return const Text('لا يوجد كوبونات صالحة');
                      }

                      return DropdownButton<int>(
                        value: selectedQrCode,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedQrCode = newValue;
                          });
                        },
                        items: validQrCodes.map((qrCode) {
                          return DropdownMenuItem<int>(
                            value: qrCode.id,
                            child: Text(
                                "مرات الاستخدام:${qrCode.numberOfUsage} | الصلاحية:${qrCode.expAt}"),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Text('لا يوجد كوبونات صالحة');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnakBar(
      {required BuildContext context, Color? color, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: color,
          content: Text(
            msg,
          )),
    );
  }

  Future<void> getLocation(BuildContext context) async {
    showSnakBar(context: context, msg: "يتم تحديد الموقع");
    bool status = await LocationService.checkGps();
    if (status) {
      Position? position = await LocationService.getLocation();
      if (position != null) {
        long = position.longitude.toString();
        lat = position.latitude.toString();
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            msg: "فشل قي الحصول على الموقع الرجاء المحاولة مجددا");
      }
      if (position != null) {
        try {
          // Use Geocoding to get the address
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
          if (placemarks.isNotEmpty) {
            Placemark place = placemarks.first;
            String address =
                "${place.country}, ${place.administrativeArea}, ${place.locality}, ${place.street}";
            setState(() {
              location.text = address;
            });
          } else {
            showSnakBar(
                context: context,
                color: Colors.red,
                msg: "فشل قي الحصول على الموقع الرجاء المحاولة مجددا");
          }
        } catch (e) {
          log("Error in reverse geocoding: $e");
          showSnakBar(
              context: context,
              color: Colors.red,
              msg: "فشل قي الحصول على الموقع الرجاء المحاولة مجددا");
        }
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            msg: "فشل قي الحصول على الموقع الرجاء المحاولة مجددا");
      }
    } else {
      showSnakBar(
          context: context,
          color: Colors.red,
          msg: "الرجاء السماح للتطبيق بالوصول الى الموقع والمحاولة مجددا");
    }
  }
}

class OrderItemTile extends StatelessWidget {
  const OrderItemTile({
    super.key,
    required this.leading,
    required this.titleText,
    required this.trailingText,
  });

  final Widget leading;
  final String titleText;
  final String trailingText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: appColor, width: 2)),
        child: Center(child: leading),
      ),
      title: Text(
        titleText,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        trailingText,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
