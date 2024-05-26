import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_offer_model.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer});
  final StoreOfferModel offer;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var shapeWidth = screenSize.width * 0.8;
    var shapeHeight = shapeWidth / 1.65;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomPaint(
        size: Size(shapeWidth, shapeHeight), // Size of your custom shape
        painter: OfferCardPainter(),
        child: SizedBox(
          width: shapeWidth,
          height: shapeHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  textAlign: TextAlign.center,
                  "%${offer.discount.toString()}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              const SizedBox(),
              Flexible(
                child: Container(
                  width: shapeWidth / 1.4,
                  height: shapeHeight / 1.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(offer.image!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: appColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OfferCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 20, size.width, size.height - 40), paint);

    const circleRadius = 12.0;

    final cutoutPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 1.4, 20), circleRadius, cutoutPaint);
    canvas.drawCircle(
        Offset(size.width / 1.4, size.height - 20), circleRadius, cutoutPaint);

    final dashPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startY = 30 + circleRadius;
    final endY = size.height - 30 - circleRadius;

    while (startY < endY) {
      canvas.drawLine(Offset(size.width / 1.4, startY),
          Offset(size.width / 1.4, startY + dashWidth), dashPaint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// class OfferCard extends StatelessWidget {
//   const OfferCard({super.key, required this.offer});
//   final StoreOfferModel offer;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: appColor,
//       ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     const SizedBox(),
      //     SizedBox(
      //       width: 50,
      //       child: Text(
      //         textAlign: TextAlign.center,
      //         "%${offer.discount.toString()}",
      //         style: const TextStyle(
      //             color: Colors.white,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 25),
      //       ),
      //     ),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Container(
      //           width: 30,
      //           height: 30,
      //           decoration: const BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.only(
      //                   bottomLeft: Radius.circular(50),
      //                   bottomRight: Radius.circular(50))),
      //         ),
      //         const SizedBox(
      //           height: 60,
      //           child: VerticalDivider(
      //             thickness: 2,
      //             color: Colors.white,
      //           ),
      //         ),
      //         Container(
      //           width: 30,
      //           height: 30,
      //           decoration: const BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(50),
      //                   topRight: Radius.circular(50))),
      //         )
      //       ],
      //     ),
      //     Container(
      //       width: MediaQuery.sizeOf(context).width / 1.5,
      //       margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: NetworkImage(offer.image!),
      //           fit: BoxFit.fill,
      //         ),
      //         borderRadius: const BorderRadius.all(Radius.circular(15)),
      //         color: appColor,
      //       ),
      //     ),
      //   ],
      // ),
//     );
//   }
// }