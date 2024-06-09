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
                  return Center(child: Text('Error: ${snapshot.stackTrace}'));
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: appColor,
                    ),
                  );
                }
                var items = snapshot.data!;
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.48,
                  ),
                  itemBuilder: (context, index) => ClothingItemCard(
                    clothingItem: items[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) return 4;
    if (screenWidth >= 800) return 3;
    return 2;
  }
}
