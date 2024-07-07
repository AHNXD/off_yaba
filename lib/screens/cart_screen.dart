import 'package:flutter/material.dart';
import 'package:off_yaba/models/order_model.dart';
import 'package:off_yaba/models/order_status.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/services/local/database_helper.dart';
import 'package:off_yaba/services/network/orders_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:off_yaba/widgets/offer_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          bell: true,
        ),
        Expanded(
          child: FutureBuilder(
            future: OrdersService.getUserOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                List<OrderModel>? orders = snapshot.data;
                return ListView.separated(
                    itemCount: orders!.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(orders[index].store!.image!)),
                        title: Text(
                          orders[index].store!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text(getOrderStatusString(orders[index].status!)),
                        trailing: Text(
                          (orders[index].total! + 2000).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      );
                    });
              }

              return const Center(child: Text("لم يتم إضافة أي عنصر للسلة"));
            },
          ),
        )
      ],
    );
  }
}
