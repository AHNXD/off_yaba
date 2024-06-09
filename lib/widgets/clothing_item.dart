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
        Navigator.of(context).pushNamed(
          ClothingItemDetailsScreen.routeName,
          arguments: {"item": clothingItem},
        );
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
                _buildImageSection(context),
                const SizedBox(height: 10),
                _buildPriceSection(context),
                const SizedBox(height: 10),
                _buildTextSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: clothingItem.image != 'no-image'
              ? Image.network(
                  clothingItem.image!,
                  height: MediaQuery.of(context).size.height * 0.25,
                  fit: BoxFit.fill,
                  width: double.infinity,
                )
              : Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: const Center(
                    child: Text('No Image Available'),
                  ),
                ),
        ),
        if (clothingItem.discount != null && clothingItem.discount! > 0)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
    );
  }

  Widget _buildTextSection(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clothingItem.name ?? "No name",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            'المتجر: ${clothingItem.store?.name ?? "Unknown"}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${(clothingItem.price! - (clothingItem.price! * clothingItem.discount! / 100)).toStringAsFixed(2)}د.ع',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                clothingItem.price?.toStringAsFixed(2) ?? "N/A",
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
          border: Border.all(color: Colors.grey.shade600, width: 2),
        ),
      );
    }).toList();
  }
}
