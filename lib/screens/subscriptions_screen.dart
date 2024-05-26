import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/coupon_offers_model.dart';
import 'package:off_yaba/services/network/qr_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});
  static String routeName = '/subscriptions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              "عروض الاشتراكات",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: appColor,
                  ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<SubscriptionModel>>(
              future: QRService.getSubscriptions(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SubscriptionModel> subs = snapshot.data!;
                  return ListView.separated(
                    itemCount: subs.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemBuilder: (context, index) {
                      SubscriptionModel sub = subs[index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 4)),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: Text(
                              "${sub.period} أشهر",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            trailing: Text(
                              "${sub.totalWithDiscount} د.ع",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: appColor),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
// return Center(
//   child: CarouselSlider.builder(
//     itemCount: subs.length,
//     itemBuilder: (context, index, realIndex) {
//       SubscriptionModel sub = subs[index];
//       return SubscriptionCard(sub: sub);
//     },
//     options: CarouselOptions(),
//   ),
// );

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.sub,
  });

  final SubscriptionModel sub;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          title: Text(
            'Period: ${sub.period} month(s)',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Number of Usage: ${sub.numberOfUsage}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Cost in One Month: ${sub.costInOneMonth}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Total: ${sub.total}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Total with Discount: ${sub.totalWithDiscount}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
