import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/services/network/qr_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});
  static String routeName = '/user-scanner-screen';
  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final bool _isloading = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  String audioasset = "audios/beep.mp3";
  final player = AudioPlayer();
  String errorMasseg = "";
  Color errorColor = Colors.black;

  // ignore: prefer_typing_uninitialized_variables
  late var response;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      camController!.pauseCamera();
    } else if (Platform.isIOS) {
      camController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    camController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const CustomAppBar(
                backArrow: true,
                cameraSettings: true,
              ),
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
                                          MediaQuery.of(context).size.width *
                                              0.6),
                                ),
                                !camOn
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        width: double.infinity,
                                        color: appColor)
                                    : Container()
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    camController = controller;
    camController!.scannedDataStream.listen((scanData) async {
      camController!.pauseCamera();
      await player.play(AssetSource(audioasset));

      QRService.scanUserCode(code: scanData.code!)
          .then((value) => showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Center(child: Text("تمت العملية بنجاح")),
                ),
              ).then((value) => camController!.resumeCamera()))
          .onError((error, stackTrace) => showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Center(child: Text("قد تم استهلاك هذا الرمز")),
                ),
              ).then((value) => camController!.resumeCamera()));

      print(scanData.code!);
    });
  }
}
