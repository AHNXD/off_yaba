import 'package:flutter/material.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/screens/clothing_item_details.dart';
import 'package:uni_color_name/uni_color_name.dart';

class ClothingItemCard extends StatelessWidget {
  final ClothingItemModel clothingItem;

  const ClothingItemCard({super.key, required this.clothingItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ClothingItemDetailsScreen.routeName,
            arguments: {"item": clothingItem});
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: clothingItem.image != 'no-image'
                          ? Image.network(
                              clothingItem.image!,
                              height: 170, // Set a fixed height for the image
                              fit: BoxFit.cover,
                              width: double
                                  .infinity, // Ensure image takes full width
                            )
                          : Container(
                              height:
                                  170, // Set a fixed height for the placeholder
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
                // Name Section
                Text(
                  clothingItem.name ?? "No name",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
                const SizedBox(height: 5),
                // Store Name Section
                Text(
                  'المتجر: ${clothingItem.store?.name ?? "Unknown"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
                const SizedBox(height: 5),
                // Price and Discount Section
                const SizedBox(height: 10),
                // Sizes Section
                // Wrap(
                //   spacing: 5,
                //   children: _buildSizeWidgets(),
                // ),
                // const SizedBox(height: 5),
                // Colors Section
                Wrap(
                  spacing: 5,
                  children: _buildColorWidgets(),
                ),
                const SizedBox(height: 5),
                // Material Section
                Text(
                  'القماش: ${clothingItem.material ?? "N/A"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Discounted Price
                    Text(
                      '${(clothingItem.price! - (clothingItem.price! * clothingItem.discount! / 100)).toStringAsFixed(2)}د.ع',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 3),
                    // Original Price
                    Text(
                      '${clothingItem.price?.toStringAsFixed(2) ?? "N/A"}د.ع',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Original Price
                //     Text(
                //       'د.ع${clothingItem.price?.toStringAsFixed(2) ?? "N/A"}',
                //       style: const TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.red,
                //         decoration: TextDecoration.lineThrough,
                //       ),
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //     // Discounted Price
                //     Text(
                //       'د.ع${(clothingItem.price! - (clothingItem.price! * clothingItem.discount! / 100)).toStringAsFixed(2)}',
                //       style: const TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.green,
                //       ),
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSizeWidgets() {
    return (clothingItem.sizes ?? []).map((size) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          size,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }).toList();
  }

  List<Widget> _buildColorWidgets() {
    var pallete = UniColorName(zeplinPalette);
    return (clothingItem.colors ?? []).map((color) {
      return Container(
        width: 25,
        height: 25,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
            color: Color(pallete.value(color)!.argbInt8),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade600, width: 2)),
      );
    }).toList();
  }
}
