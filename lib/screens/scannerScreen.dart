import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/services/network/code_scanner_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final bool _isloading = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String audioasset = "audios/beep.mp3";
  final player = AudioPlayer();
  String errorMasseg = "";
  Color errorColor = Colors.black;
  bool camOn = true;
  Color camOncolor = Colors.blue;
  // ignore: prefer_typing_uninitialized_variables
  late var response;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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
                color: appColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
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
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              camOn = !camOn;
                              camOncolor = camOn ? Colors.green : Colors.red;
                              if (camOn) {
                                controller?.resumeCamera();
                              } else {
                                controller?.stopCamera();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: camOncolor,
                          )),
                      IconButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        icon: FutureBuilder<bool?>(
                          future: controller?.getFlashStatus(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data != null) {
                              return snapshot.data!
                                  ? const Icon(
                                      Icons.flash_on,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.flash_off,
                                      color: Colors.red,
                                    );
                            } else {
                              return const Icon(
                                Icons.flash_off,
                                color: Colors.red,
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.switch_camera,
                            color: appColor,
                          ))
                    ],
                  ),
                ),
              ],
            )),
        Expanded(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                primary: true,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: appColor,
                              blurRadius: 15.0,
                              offset: Offset(0.0, 0.75))
                        ],
                      ),
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                            overlay: QrScannerOverlayShape(
                                borderWidth: 15,
                                borderColor: appColor,
                                borderLength: 20,
                                borderRadius: 10,
                                cutOutSize:
                                    MediaQuery.of(context).size.width * 0.6),
                          ),
                          !camOn
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: double.infinity,
                                  color: appColor)
                              : Container()
                        ],
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //       boxShadow: const <BoxShadow>[
                  //         BoxShadow(
                  //             color: Colors.black,
                  //             blurRadius: 10.0,
                  //             offset: Offset(0.0, 2))
                  //       ],
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: appColor),
                  //   child: Center(
                  //     child: Column(
                  //       children: [
                  //         _isloading
                  //             ? Text(
                  //                 textAlign: TextAlign.center,
                  //                 lang == "ar"
                  //                     ? "تم المسح "
                  //                     : "Scanning is completed",
                  //                 style: const TextStyle(
                  //                     fontSize: 15,
                  //                     fontWeight: FontWeight.bold),
                  //               )
                  //             : Text(
                  //                 lang == "ar" ? 'امسح الرمز' : "Scan the Code",
                  //                 style: const TextStyle(
                  //                     fontSize: 20,
                  //                     fontFamily: "cocon-next-arabic",
                  //                     fontWeight: FontWeight.bold)),
                  //         Center(
                  //             child: Text(
                  //           errorMasseg,
                  //           style: TextStyle(color: errorColor),
                  //         )),
                  //         ElevatedButton(
                  //             onPressed: () {},
                  //             child: Text(
                  //                 lang == "ar" ? "إضافة العرض" : "Add Offer"))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      // player.play(AssetSource(audioasset));

      CodeScannerService.scanCode(code: scanData.code!)
          .then((value) => showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Center(child: Text("تمت العملية بنجاح")),
                ),
              ).then((value) => controller.resumeCamera()))
          .onError((error, stackTrace) => showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Center(child: Text("قد تم استهلاك هذا الرمز")),
                ),
              ).then((value) => controller.resumeCamera()));

      print(scanData.code!);

      // if (result == null || result?.code != scanData.code) {
      //   log("not found yet");
      //   result = scanData;
      //   setState(() {
      //     errorColor = appColor;
      //     errorMasseg = "Please wait...";
      //   });

      //   setState(() {
      //     _isloading = true;
      //     errorColor = Colors.black;
      //     errorMasseg = "";
      //   });
      // }
    });
  }
}
