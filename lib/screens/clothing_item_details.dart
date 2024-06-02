import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/screens/resturant_screen.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:uni_color_name/uni_color_name.dart';

class ClothingItemDetailsScreen extends StatelessWidget {
  const ClothingItemDetailsScreen({super.key});
  static String routeName = '/clothing-item-details';

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    ClothingItemModel clothingItem = arguments['item'];

    return Scaffold(
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(
                  isBackable: false,
                ),
                // Image Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: clothingItem.image != 'no-image'
                                ? Image.network(
                                    clothingItem.image!,
                                    // Set a fixed height for the image

                                    width: double
                                        .infinity, // Ensure image takes full width
                                  )
                                : Container(
                                    height:
                                        200, // Set a fixed height for the placeholder
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: double
                                        .infinity, // Ensure container takes full width
                                    child: const Center(
                                      child: Text('No Image Available'),
                                    ),
                                  ),
                          ),
                          if (clothingItem.discount != null &&
                              clothingItem.discount! > 0)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '-${clothingItem.discount!.toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clothingItem.name!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    clothingItem.store!.name!,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${(clothingItem.price! - (clothingItem.price! * clothingItem.discount! / 100)).toStringAsFixed(2)}د.ع',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      clothingItem.price?.toStringAsFixed(2) ??
                                          "N/A",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "${clothingItem.discount!.toString()}%-",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        selectedTileColor: Colors.white,
                        selected: true,
                        onTap: () => Navigator.of(context).pushNamed(
                            RestaurantScreen.routeName,
                            arguments: {"store": clothingItem.store}),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(clothingItem.store!.image!),
                        ),
                        title: Text(clothingItem.store!.name!),
                        subtitle: Text(
                          clothingItem.store!.address!,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        trailing: const Icon(Icons.link),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'المقاسات:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: clothingItem.sizes!
                                  .map(
                                    (e) => Expanded(child: SizeBox(size: e)),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'الألوان:',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  _buildColorWidgets(clothingItem.colors!),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Text(
                          'القماش: ${clothingItem.material ?? "N/A"}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "التفاصيل:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Voluptate nostrud qui minim labore eu magna enim veniam. Ipsum ea fugiat proident aliqua veniam culpa et. Aute nulla enim quis dolor pariatur proident duis ad enim eiusmod quis. Aliquip consectetur velit ad veniam pariatur pariatur. Sit cupidatat id esse pariatur sit est anim do do excepteur enim laborum nostrud. Adipisicing et et occaecat officia.',
                              style: TextStyle(wordSpacing: 5),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            shape: const BeveledRectangleBorder(),
            minimumSize: const Size.fromHeight(kToolbarHeight),
            maximumSize: const Size.fromHeight(kToolbarHeight),
          ),
          onPressed: () {},
          label: const Text(
            "إضافة الى السلة",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ));
  }

  List<Widget> _buildSizeWidgets(List sizes) {
    return (sizes ?? []).map((size) {
      return Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade700, width: 2),
        ),
        child: Center(
          child: Text(
            size,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildColorWidgets(List colors) {
    var pallete = UniColorName(zeplinPalette);
    return (colors).map((color) {
      return Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
            color: Color(pallete.value(color)!.argbInt8),
            border: Border.all(color: Colors.grey.shade600, width: 2),
            borderRadius: BorderRadius.circular(10)),
      );
    }).toList();
  }
}

class SizeBox extends StatelessWidget {
  final String size;

  const SizeBox({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Text(
        size,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
