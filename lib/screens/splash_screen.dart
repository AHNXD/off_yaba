import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/services/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/intro.mp4',
    )..initialize().then((_) {
        _controller!.play();
        _controller!.setLooping(false);
        setState(() {});
      });
    Future.delayed(const Duration(seconds: 8), () {
      checkTokenAndNavigate();
    });
  }

  void checkTokenAndNavigate() async {
    String? token = await CacheHelper.getData(key: "token");
    if (token != null) {
      Navigator.of(context).pushReplacement(goRoute(x: const RouterScreen()));
    } else {
      Navigator.of(context).pushReplacement(goRoute(x: const AuthScreen()));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _controller?.value.isInitialized ?? false
          ? Container(
              color: const Color(0xff1c617e),
              child: Center(
                child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!)),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
