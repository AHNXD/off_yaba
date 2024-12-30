import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/screens/clothing_item_details.dart';
import 'package:off_yaba/services/network/cart_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:uni_color_name/uni_color_name.dart';

class ClothingItemOrderScreen extends StatefulWidget {
  final ClothingItemModel clothingItem;

  const ClothingItemOrderScreen({super.key, required this.clothingItem});

  @override
  _ClothingItemOrderScreenState createState() =>
      _ClothingItemOrderScreenState();
}

class _ClothingItemOrderScreenState extends State<ClothingItemOrderScreen> {
  String extraNotes = '';
  String? selectedSize;
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          shape: const BeveledRectangleBorder(),
          minimumSize: const Size.fromHeight(kToolbarHeight),
          maximumSize: const Size.fromHeight(kToolbarHeight),
        ),
        onPressed: () {
          CartService.addItemToCart(
                  itemId: widget.clothingItem.itemId!,
                  itemCount: widget.clothingItem.itemCount == 0
                      ? 1
                      : widget.clothingItem.itemCount,
                  extra_notes: extraNotes)
              .then(
            (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تمت الإضافة للسلة بنجاح"),
                ),
              );
              Navigator.pop(context);
              return;
            },
          );
        },
        label: const Text(
          "إضافة الى السلة",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(),
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
                        child: widget.clothingItem.image != 'no-image'
                            ? Image.network(
                                widget.clothingItem.image!,
                                width: double.infinity,
                              )
                            : Container(
                                height: 200,
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
                      if (widget.clothingItem.discount != null &&
                          widget.clothingItem.discount! > 0)
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
                              '-${widget.clothingItem.discount!.toStringAsFixed(0)}%',
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
                              widget.clothingItem.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                widget.clothingItem.store!.name!,
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
                              '${(widget.clothingItem.price! - (widget.clothingItem.price! * widget.clothingItem.discount! / 100)).toStringAsFixed(2)}د.ع',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.clothingItem.price
                                          ?.toStringAsFixed(2) ??
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
                                  "${widget.clothingItem.discount!.toString()}%-",
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
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "يرجى اختيار المقاس",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: widget.clothingItem.sizes!
                              .map(
                                (e) => Expanded(
                                  child: SizeBox(
                                    size: e,
                                    isSelected: selectedSize == e,
                                    onTap: () {
                                      setState(() {
                                        selectedSize = e;
                                        extraNotes = 'Size: $selectedSize';
                                      });
                                    },
                                  ),
                                ),
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
                          'يرجى إختيار اللون',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                              _buildColorWidgets(widget.clothingItem.colors!),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildColorWidgets(List colors) {
    var pallete = UniColorName(zeplinPalette);
    return colors.map((color) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = Color(pallete.value(color)!.argbInt8);
            extraNotes += ', Color: $color';
          });
        },
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: Color(pallete.value(color)!.argbInt8),
            border: Border.all(
              color: selectedColor == Color(pallete.value(color)!.argbInt8)
                  ? Colors.green
                  : Colors.grey.shade600,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }).toList();
  }
}
