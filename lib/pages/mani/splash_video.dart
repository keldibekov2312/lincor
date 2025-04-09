import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/register_page.dart';
import 'home_page.dart';
import 'onboarding_page.dart';

class SplashVideoPage extends StatefulWidget {
  @override
  _SplashVideoPageState createState() => _SplashVideoPageState();
}

class _SplashVideoPageState extends State<SplashVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() async {
      if (_controller.value.position >=
          _controller.value.duration - Duration(milliseconds: 500)) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool hasSeenOnboarding = prefs.getBool("hasSeenOnboarding") ?? false;
        bool hasRegistered = prefs.getBool("hasRegistered") ?? false;

        if (!hasSeenOnboarding) {
          await prefs.setBool("hasSeenOnboarding", true);
          Get.offAll(() => OnboardingPage());
        } else if (hasRegistered) {
          Get.offAll(() => HomePage());
        } else {
          Get.offAll(() => RegisterPage());
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
