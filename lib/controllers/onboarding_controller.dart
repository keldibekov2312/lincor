import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/auth/register_page.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs; // Hozirgi slayder indexi

  // 📌 Keyingi slayderga o‘tish
  void nextPage(int pageCount) {
    if (currentPage.value < pageCount - 1) {
      currentPage.value++;
    } else {
      completeOnboarding();
    }
  }

  // 📌 "Skip" tugmasi bosilganda Onboardingni tugatish
  Future<void> skipOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasSeenOnboarding", true);
    Get.offAll(() => RegisterPage());
  }

  // 📌 Oxirgi onboarding tugagandan keyin Register sahifasiga o‘tish
  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasSeenOnboarding", true);
    Get.offAll(() => RegisterPage());
  }
}
