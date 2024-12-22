import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({required this.long, required this.lati, super.key});
  static String routeName = '/show-map';
  final String long;
  final String lati;
  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  int loadingPercentage = 0;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${widget.long},${widget.lati}'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.restart_alt),
          onPressed: () {
            controller.reload();
          }),
      appBar: AppBar(),
      body: SafeArea(
          child: Directionality(
        textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ),
      )),
    );
  }
}
