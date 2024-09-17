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

import 'package:flutter/material.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/screens/order_item_details_screen.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({super.key, required this.offer, this.isDeleteable = false});
  final StoreOfferModel offer;
  final bool isDeleteable;

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
                .pushNamed(OrderItemDeatils.routeName, arguments: {
              "offer": widget.offer,
            }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              widget.offer.image!,
                              height: MediaQuery.of(context).size.height * 0.1,
                            )),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.offer.name!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade700),
                          ),
                          // Text(
                          //   widget.offer.body!,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .bodySmall!
                          //       .copyWith(color: Colors.grey),
                          // ),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "${widget.offer.price} دينار",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade700),
                ),
              ),
            ),
          ],
        ));
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