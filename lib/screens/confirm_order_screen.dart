import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/cart_model.dart';
import 'package:off_yaba/models/code_scanner_model.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/services/network/cart_service.dart';
import 'package:off_yaba/services/network/qr_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

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
        onPressed: (location.text.isNotEmpty && phone.text.isNotEmpty)
            ? () {
                CartService.checkoutCart(
                        location: location.text,
                        phone: phone.text,
                        code_id: selectedQrCode)
                    .then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تمت عملية الطلب بنجاح"),
                        showCloseIcon: true,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context)
                        .pushReplacementNamed(RouterScreen.routeName);
                  },
                );
              }
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("قم بتحديد جميع البيانات"),
                    showCloseIcon: true,
                    duration: Duration(seconds: 2),
                  ),
                );
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
                TextFormField(
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
