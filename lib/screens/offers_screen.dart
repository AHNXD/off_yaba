import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/code_scanner_model.dart';
import 'package:off_yaba/screens/offer_details_screen.dart';
import 'package:off_yaba/screens/scanner_screen.dart';
import 'package:off_yaba/services/network/qr_service.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          margin: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              gradient: const LinearGradient(colors: [Colors.blue, appColor]),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.13,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const SizedBox(
              //   height: 16,
              // ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ScannerScreen.routeName);
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  weight: 2,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Off ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          shadows: [])),
                  TextSpan(
                      text: "Yaba",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))
                ]),
              ),

              // const SizedBox(
              //   height: 16,
              // ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - 200,
            child: FutureBuilder<List<CodeScannerModel>?>(
                future: QRService.getUserCodes(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('لا يوجد لديك خصومات بعد'),
                    );
                  }
                  if (snapshot.hasData) {
                    List<CodeScannerModel> codes = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: codes.length,
                        itemBuilder: (BuildContext, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, OfferDetailsScreen.routeName,
                                  arguments: {"code": codes[index].code});
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  gradient: codes[index].isValid!
                                      ? const LinearGradient(
                                          colors: [Colors.blue, appColor])
                                      : const LinearGradient(colors: [
                                          Colors.red,
                                          Colors.redAccent,
                                        ]),
                                  color: codes[index].isValid!
                                      ? appColor
                                      : Colors.red,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.white,
                                      ),
                                      Icon(
                                        Icons.qr_code,
                                        color: Colors.white,
                                        size: 80,
                                      ),
                                      // QrImageView(
                                      //   data: codes[index].code!,
                                      //   version: QrVersions.auto,
                                      //   eyeStyle: const QrEyeStyle(
                                      //       color: Colors.white),
                                      //   size: 80.0,
                                      //   foregroundColor: Colors.white,
                                      // ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "صالح",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        codes[index].numberOfUsage.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const Text(
                                        "مرة",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    color: Colors.white,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "صالح لغاية",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        codes[index].expAt!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                  // Text(
                                  //   lang == "ar" ? "انقر للعرض" : "Tap to show",
                                  //   style: const TextStyle(
                                  //       fontSize: 24,
                                  //       fontFamily: "cocon-next-arabic",
                                  //       color: Colors.white),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        )
      ],
    );
  }
}