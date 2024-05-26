import 'package:flutter/material.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/services/network/stores_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:off_yaba/widgets/store_card.dart';

class AllDiscountsScreen extends StatelessWidget {
  const AllDiscountsScreen({super.key});
  static String routeName = "/all-discounts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(": اقوى التخفيضات",
                      style: TextStyle(
                          fontFamily: "cocon-next-arabic",
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              FutureBuilder(
                future: StoreService.getStoresWithBestOffers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Expanded(
                      child: Center(
                        child: Text("لقد حدثت مشكلة ما يرجى المحاولة لاحقا"),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    List<StoreModel> stores = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: stores.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) =>
                            StoreCard(store: stores[index]),
                      ),
                    );
                  }

                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
