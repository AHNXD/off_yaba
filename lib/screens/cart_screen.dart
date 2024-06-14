import 'package:flutter/material.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/services/local/database_helper.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:off_yaba/widgets/offer_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          backArrow: false,
        ),
        Expanded(
          child: FutureBuilder(
            future: DatabaseHelper.getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                List<StoreOfferModel>? offers = snapshot.data;
                return ListView.separated(
                  itemCount: offers!.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) =>
                      OfferCard(offer: offers[index]),
                );
              }

              return const Center(child: Text("لم يتم إضافة أي عنصر للسلة"));
            },
          ),
        )
      ],
    );
  }
}
