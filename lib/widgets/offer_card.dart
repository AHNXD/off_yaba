// import 'package:flutter/material.dart';
// import 'package:off_yaba/constant.dart';
// import 'package:off_yaba/models/store_offer_model.dart';

// class OfferCard extends StatelessWidget {
// const OfferCard({super.key, required this.offer});
// final StoreOfferModel offer;

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     var shapeWidth = screenSize.width * 0.8;
//     var shapeHeight = shapeWidth / 1.65;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: CustomPaint(
//         size: Size(shapeWidth, shapeHeight), // Size of your custom shape
//         painter: OfferCardPainter(),
//         child: SizedBox(
//           width: shapeWidth,
//           height: shapeHeight,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(
//                 width: 50,
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   "%${offer.discount.toString()}",
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25),
//                 ),
//               ),
//               const SizedBox(),
//               Flexible(
//                 child: Container(
//                   width: shapeWidth / 1.4,
//                   height: shapeHeight / 1.4,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(offer.image!),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: const BorderRadius.all(Radius.circular(15)),
//                     color: appColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OfferCardPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.lightBlue
//       ..style = PaintingStyle.fill;

//     canvas.drawRect(Rect.fromLTWH(0, 20, size.width, size.height - 40), paint);

//     const circleRadius = 12.0;

//     final cutoutPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     canvas.drawCircle(Offset(size.width / 1.4, 20), circleRadius, cutoutPaint);
//     canvas.drawCircle(
//         Offset(size.width / 1.4, size.height - 20), circleRadius, cutoutPaint);

//     final dashPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;

//     const dashWidth = 5.0;
//     const dashSpace = 5.0;
//     double startY = 30 + circleRadius;
//     final endY = size.height - 30 - circleRadius;

//     while (startY < endY) {
//       canvas.drawLine(Offset(size.width / 1.4, startY),
//           Offset(size.width / 1.4, startY + dashWidth), dashPaint);
//       startY += dashWidth + dashSpace;
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/services/local/database_helper.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({super.key, required this.offer});
  final StoreOfferModel offer;

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: appColor, width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.offer.title!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "9000 دينار",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text(
                            widget.offer.body!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(widget.offer.image!))),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    widget.offer.itemCount++;
                    print(widget.offer.itemCount);
                    if (widget.offer.itemCount == 1) {
                      await DatabaseHelper.addCartItem(widget.offer).then(
                        (value) {
                          print(value);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("تمت الإضافة للسلة بنجاح")));
                          setState(() {});
                          return;
                        },
                      );
                    }
                    await DatabaseHelper.updateCartItem(widget.offer);
                    setState(() {});
                  },
                  icon: const Icon(
                    CupertinoIcons.add,
                    size: 20,
                  ),
                  color: Colors.white,
                ),
                const VerticalDivider(
                  color: Colors.white,
                ),
                Text(
                  widget.offer.itemCount.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
                const VerticalDivider(
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: widget.offer.itemCount == 0
                      ? null
                      : () async {
                          widget.offer.itemCount--;
                          if (widget.offer.itemCount == 0) {
                            await DatabaseHelper.deleteCartItem(widget.offer)
                                .then((va) => setState(() {}));
                          }
                          await DatabaseHelper.updateCartItem(widget.offer)
                              .then((value) => setState(() {}));
                        },
                  icon: const Icon(
                    CupertinoIcons.minus,
                    size: 20,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}


// Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(image: NetworkImage(offer.image!))),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Text(offer.body!),
//               const Text("9000"),
//             ],
//           ),
//         ],
//       ),
//     );