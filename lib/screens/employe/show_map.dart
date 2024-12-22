import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({super.key});
  static String routeName = '/show-map';

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  Map? loc;
  int loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    loc = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Directionality(
        textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
        child: Stack(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: WebViewController()
                  ..loadRequest(
                    Uri.parse(
                        'https://www.google.com/maps/search/?api=1&query=${loc!['long']},${loc!['lati']}'),
                  ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
