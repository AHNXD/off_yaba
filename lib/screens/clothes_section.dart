import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/services/network/clothing_service.dart';
import 'package:off_yaba/widgets/clothing_item.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';

class ClothesSectionScreen extends StatefulWidget {
  const ClothesSectionScreen({super.key});
  static String routeName = '/clothes-section';

  @override
  State<ClothesSectionScreen> createState() => _ClothesSectionScreenState();
}

class _ClothesSectionScreenState extends State<ClothesSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: FutureBuilder<List<ClothingItemModel>>(
              future: ClothingService.getClothingItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  var items = snapshot.data;
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: items!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10.0, // Spacing between columns
                            mainAxisSpacing: 10.0, // Spacing between rows
                            childAspectRatio: 0.44),
                    itemBuilder: (context, index) => ClothingItemCard(
                      clothingItem: items[index],
                    ),
                  );
                }
                return const CircularProgressIndicator(
                  color: appColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
