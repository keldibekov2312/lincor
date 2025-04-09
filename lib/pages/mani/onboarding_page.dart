import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding_controller.dart';
import '../auth/login_page.dart';
import '../auth/register_page.dart';


class OnboardingPage extends StatelessWidget {
  final OnboardingController onboardingController = Get.find();

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Xush kelibsiz!",
      "description": "Ilovamizdan foydalanish uchun bir necha qadamlarni bajaring.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Tez va oson foydalanish",
      "description": "Ilovamiz orqali barcha imkoniyatlardan foydalaning.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Boshlashga tayyormisiz?",
      "description": "Endi ro‘yxatdan o‘tib, ilovadan foydalanishni boshlang!",
      "image": "assets/images/onboarding3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => onboardingController.currentPage.value < 2
              ? Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: onboardingController.skipOnboarding,
              child: Text("Skip"),
            ),
          )
              : SizedBox.shrink()),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                onboardingController.currentPage.value = index;
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                image: onboardingData[index]["image"]!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => buildDot(index),
            ),
          ),
          SizedBox(height: 20),
          Obx(() => onboardingController.currentPage.value == onboardingData.length - 1
              ? Column(
            children: [
              ElevatedButton(
                onPressed: () => Get.to(() => LoginPage()),
                child: Text("Kirish"),
              ),
              TextButton(
                onPressed: () => Get.to(() => RegisterPage()),
                child: Text("Ro‘yxatdan o‘tish"),
              ),
            ],
          )
              : ElevatedButton(
            onPressed: () {
              onboardingController.nextPage(onboardingData.length);
            },
            child: Text("Keyingisi"),
          )),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Obx(() => Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: onboardingController.currentPage.value == index ? 20 : 10,
      decoration: BoxDecoration(
        color: onboardingController.currentPage.value == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    ));
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, description, image;

  OnboardingContent({required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 200),
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}
