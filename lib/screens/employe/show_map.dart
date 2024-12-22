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
        onNavigationRequest: (navigation) {
          return NavigationDecision.navigate;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: PopupMenuButton(
        icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: appColor, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.menu)),
        onSelected: (value) async {
          if (value == "Back") {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No back history item')),
              );
              return;
            }
          } else if (value == "Forward") {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No forward history item')),
              );
              return;
            }
          } else if (value == "Refresh") {
            await controller.reload();
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Back',
            child: Center(child: Icon(Icons.arrow_back_ios_new)),
          ),
          const PopupMenuItem(
            value: 'Forward',
            child: Center(child: Icon(Icons.arrow_forward_ios)),
          ),
          const PopupMenuItem(
            value: 'Refresh',
            child: Center(child: Icon(Icons.restart_alt)),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(children: [
            TextSpan(
                text: "Off ",
                style: TextStyle(
                    color: appColor,
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
      ),
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

// class NavigationControls extends StatelessWidget {
//   const NavigationControls({required this.controller, super.key});

//   final WebViewController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30), color: appColor),
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: () async {
//                 final messenger = ScaffoldMessenger.of(context);
//                 if (await controller.canGoBack()) {
//                   await controller.goBack();
//                 } else {
//                   messenger.showSnackBar(
//                     const SnackBar(content: Text('No back history item')),
//                   );
//                   return;
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_ios),
//               onPressed: () async {
//                 final messenger = ScaffoldMessenger.of(context);
//                 if (await controller.canGoForward()) {
//                   await controller.goForward();
//                 } else {
//                   messenger.showSnackBar(
//                     const SnackBar(content: Text('No forward history item')),
//                   );
//                   return;
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.replay),
//               onPressed: () {
//                 controller.reload();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
