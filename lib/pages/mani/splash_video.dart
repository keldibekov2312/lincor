import 'dart:async';

import 'package:LinCor/controllers/splash_controller.dart';
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
  var controller = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    controller.initVideoPlayer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (_) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: controller.videoPlayerController.value.isInitialized
                ? VideoPlayer(controller.videoPlayerController)
                : CircularProgressIndicator(),
          );
        }
      ),
          );
  }
}
