import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/order_model.dart';
import 'package:off_yaba/models/order_status.dart';
import 'package:off_yaba/screens/confirm_order_screen.dart';
import 'package:off_yaba/screens/employe/show_map.dart';
import 'package:off_yaba/screens/employe/store_orders_screen.dart';
import 'package:off_yaba/services/network/api_service.dart';
import 'package:off_yaba/services/network/orders_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({super.key});
  static String routeName = '/order-details';

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  void _showOrderItemDialog(BuildContext context, Items orderItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(orderItem.item!.name!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                  "${DioHelper.baseUrl}image?path=${orderItem.item!.image!}"), // Display item image
              const SizedBox(height: 10),
              Text('الكمية: ${orderItem.quantity}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    OrderModel order = arguments['order'];
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const CustomAppBar(
                backArrow: true,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: order.items!.length,
                  itemBuilder: (context, index) {
                    print("order: ${order.items![index].toJson()}");
                    return GestureDetector(
                      onTap: () {
                        _showOrderItemDialog(context, order.items![index]);
                      },
                      child: Column(
                        children: [
                          OrderItemTile(
                            leading: Text(
                              order.items![index].quantity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: appColor,
                                      fontWeight: FontWeight.bold),
                            ),
                            titleText: order.items![index].item!.name!,
                            trailingText:
                                '${order.items![index].item!.price! * order.items![index].quantity!}د.ع',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                  textAlign: TextAlign.start,
                                  "ملاحظات: ${order.items![index].extraNotes ?? ""}"),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              ExpansionTile(
                title: const Text("العنوان"),
                leading: const Icon(Icons.location_pin),
                dense: true,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerRight,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                shape: Border.all(color: Colors.transparent),
                children: [Text(order.location!)],
              ),
              ExpansionTile(
                title: const Text("الرقم"),
                leading: const Icon(Icons.phone),
                dense: true,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerRight,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
                shape: Border.all(color: Colors.transparent),
                children: [Text(order.phone!)],
              ),
              if (order.longitude != null && order.latitude != null)
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ShowMapScreen.routeName,
                          arguments: {
                            'long': order.longitude,
                            'lati': order.latitude
                          });
                    },
                    child: Text(
                        lang == "ar" ? "اظهار على الخريطة" : "Show on Map")),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (order.status == OrderStatus.pendingConfirmation)
                      ElevatedButton(
                        onPressed: () {
                          OrdersService.acceptOrder(orderId: order.id!).then(
                            (value) {
                              Navigator.pop(context);
                              return Navigator.of(context).pushReplacementNamed(
                                StoreOrdersScreen.routeName,
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "قبول",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (order.status == OrderStatus.pendingConfirmation)
                      ElevatedButton(
                        onPressed: () {
                          OrdersService.cancelOrder(orderId: order.id!).then(
                            (value) =>
                                Navigator.of(context).pushReplacementNamed(
                              StoreOrdersScreen.routeName,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          "الغاء",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    if (order.status == OrderStatus.confirmed &&
                        order.status != OrderStatus.inTransit)
                      ElevatedButton(
                        onPressed: () {
                          OrdersService.deliverOrder(orderId: order.id!).then(
                            (value) =>
                                Navigator.of(context).pushReplacementNamed(
                              StoreOrdersScreen.routeName,
                            ),
                          );
                        },
                        style:
                            ElevatedButton.styleFrom(backgroundColor: appColor),
                        child: const Text(
                          "تم التوصيل",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
