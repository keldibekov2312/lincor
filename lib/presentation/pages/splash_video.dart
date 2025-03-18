import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../controller/aoth_controller.dart';
import 'home_page.dart';
import 'onboarding_page.dart';
import 'register_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  final AuthController authController = Get.find<AuthController>();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

     _navigateAfterVideo();

  }

  // 📌 Video tugagachiga qadar foydalanuvchini tekshirish va sahifani o‘zgartirish
  Future<void> _navigateAfterVideo() async {
    await Future.delayed(Duration(seconds: 5)); // 5 soniya kutish

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool("hasSeenOnboarding") ?? false; // 🔹 Onboarding ko‘rildimi?
    bool hasRegistered = prefs.getBool("hasRegistered") ?? false; // 🔹 Foydalanuvchi oldin ro‘yxatdan o‘tganmi?

    if (!hasSeenOnboarding) {
      await prefs.setBool("hasSeenOnboarding", true);
      Get.offAll(() => OnboardingPage()); // 🔹 Agar foydalanuvchi onboardingni ko‘rmagan bo‘lsa, uni ochamiz
    } else if (hasRegistered) {
      Get.offAll(() => HomePage()); // 🔹 Agar oldin ro‘yxatdan o‘tgan bo‘lsa, HomePage ga o‘tish
    } else {
      Get.offAll(() => RegisterPage()); // 🔹 Agar ro‘yxatdan o‘tmagan bo‘lsa, RegisterPage ga o‘tish
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // Status bar navigatsiya panelini tiklash
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
