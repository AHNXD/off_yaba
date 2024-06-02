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
                      return SubscriptionCard(
                        sub: sub,
                        isGold: sub == subs.last,
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

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.sub,
    this.isGold = false,
  });

  final SubscriptionModel sub;
  final bool isGold;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          gradient: isGold
              ? const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.yellow,
                    Color(0xffad9c00),
                  ],
                )
              : LinearGradient(colors: [Colors.blue.shade600, appColor]),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 4)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          leading: Text(
            "${sub.period} أشهر",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),
          trailing: Text(
            "${sub.totalWithDiscount} د.ع",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
        ),
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


