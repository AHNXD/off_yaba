import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/screens/resturant_screen.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    super.key,
    required this.store,
  });

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestaurantScreen.routeName,
            arguments: {"store": store});
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      image: store.image != null
                          ? DecorationImage(
                              image: NetworkImage(store.image!),
                              fit: BoxFit.fill,
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                  "assets/images/no-image-found.png"),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 5, horizontal: 10),
                  //     decoration: const BoxDecoration(
                  //       color: Colors.black,
                  //       // borderRadius: BorderRadius.circular(5),
                  //       shape: BoxShape.circle,
                  //     ),
                  // child: Text('${store.discount!.toStringAsFixed(0)}%',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .titleLarge!
                  //         .copyWith(color: Colors.white)),
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      // lang == "ar"
                      //     ? "اسم المطعم"
                      //     : "Restaurant Name",
                      store.name!,
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "cocon-next-arabic",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    store.section!.name!,
                  ),
                ],
              ),
              Align(
                alignment:
                    lang == "ar" ? Alignment.centerRight : Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: ' التخفيض العام: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black)),
                        TextSpan(
                            text: "${store.discount!.toStringAsFixed(0)}%",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: appColor))
                      ]),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: appColor,
                        ),
                        Text(
                          store.distance!.round().toString(),
                        ),
                        Text(
                          lang == "ar" ? "كم" : "km",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class StoreCard extends StatelessWidget {
//   const StoreCard({
//     super.key,
//     required this.store,
//   });

//   final StoreModel store;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, RestaurantScreen.routeName,
//                 arguments: {"store": store});
//           },
          // child: Container(
          //   height: 200,
          //   decoration: BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 2,
          //         blurRadius: 3,
          //         offset: const Offset(0, 1), // changes position of shadow
          //       ),
          //     ],
          //     borderRadius: BorderRadius.circular(16),
          //     image: store.image != null
          //         ? DecorationImage(
          //             image: NetworkImage(store.image!),
          //             fit: BoxFit.fill,
          //           )
          //         : const DecorationImage(
          //             image: AssetImage("assets/images/no-image-found.png"),
          //             fit: BoxFit.fill,
          //           ),
          //   ),
          // ),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Flexible(
    //           child: Text(
    //               // lang == "ar"
    //               //     ? "اسم المطعم"
    //               //     : "Restaurant Name",
    //               store.name!,
    //               maxLines: 1,
    //               style: const TextStyle(
    //                   overflow: TextOverflow.ellipsis,
    //                   fontFamily: "cocon-next-arabic",
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold)),
    //         ),
    //       ],
    //     ),
    //     Align(
    //       alignment:
    //           lang == "ar" ? Alignment.centerRight : Alignment.centerLeft,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             store.section!.name!,
    //             style: const TextStyle(color: Colors.grey),
    //           ),
    //           Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               const Icon(
    //                 Icons.pin_drop,
    //                 color: appColor,
    //               ),
    //               Text(
    //                 store.distance!.round().toString(),
    //                 style: const TextStyle(color: Colors.grey),
    //               ),
    //               Text(
    //                 lang == "ar" ? "كم" : "km",
    //                 style: const TextStyle(color: Colors.grey),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     const Divider(
    //       color: appColor,
    //     )
    //   ],
    // );
//   }
// }
