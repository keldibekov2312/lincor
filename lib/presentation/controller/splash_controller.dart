import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  late VideoPlayerController _videoController;

  @override
  void dispose() {
    if (_videoController.value.isInitialized) {
      _videoController.pause(); // 🔹 Videoni to‘xtatish
      _videoController.dispose(); // 🔹 Video pleer resurslarini tozalash
    }
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    _videoController = VideoPlayerController.asset("assets/videos/gemini_video.mp4")
      ..initialize().then((_) {
        _videoController.play();
        update(); // UI ni yangilash
      });

    // 5 soniyadan keyin HomePage`ga o'tish
    Future.delayed(Duration(seconds: 5), () {
      Get.offNamed('/home'); // Home sahifasiga o'tish
    });
  }

  @override
  void onClose() {
    _videoController.dispose();
    super.onClose();
  }
}







































































