import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/order_model.dart';
import 'package:off_yaba/models/order_status.dart';
import 'package:off_yaba/screens/employe/order_details_screen.dart';
import 'package:off_yaba/services/network/orders_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

class StoreOrdersScreen extends StatefulWidget {
  const StoreOrdersScreen({super.key});
  static String routeName = "/store-orders";

  @override
  State<StoreOrdersScreen> createState() => _StoreOrdersScreenState();
}

class _StoreOrdersScreenState extends State<StoreOrdersScreen> {
  late Future<List<OrderModel>?> _futureData;
  @override
  void initState() {
    super.initState();
    _futureData = OrdersService.getStoreOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const CustomAppBar(
              backArrow: true,
            ),
            Expanded(
              child: FutureBuilder(
                future: _futureData,
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
                          return StoreOrderTile(order: orders[index]);
                        });
                  }

                  return const Center(
                      child: Text("لم يتم إضافة أي عنصر للسلة"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreOrderTile extends StatelessWidget {
  const StoreOrderTile({
    super.key,
    required this.order,
  });

  final OrderModel order;

  Color getStatusColor() {
    switch (order.status) {
      case OrderStatus.pendingConfirmation:
        return Colors.amber;
      case OrderStatus.confirmed:
        return Colors.green;
      case OrderStatus.canceled:
        return Colors.red;
      case OrderStatus.inTransit:
        return appColor;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(OrderDetailsScreen.routeName, arguments: {"order": order}),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: getStatusColor(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.location!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              order.phone!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Text(getOrderStatusString(order.status!)),
        trailing: Text(
          (order.total! + 2000).toString(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
