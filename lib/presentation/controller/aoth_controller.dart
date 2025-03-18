import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/OTP_page.dart';
import '../pages/home_page.dart';
import '../pages/register_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  var isAuthenticated = false.obs;

  // 📌 Telefon raqami bilan ro‘yxatdan o‘tish
  Future<void> registerUser(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _saveUserSession();
          Get.offAll(() => HomePage());
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Xatolik", e.message ?? "Telefon raqam bilan muammo yuz berdi.");
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          Get.to(() => OTPVerificationPage(phoneNumber: phoneNumber));
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar("Xatolik", "Telefon raqamni tekshirib qaytadan urinib ko‘ring.");
    }
  }

  // 📌 OTP ni tekshirish
  Future<void> verifyOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      _saveUserSession();
      Get.offAll(() => HomePage());
    } catch (e) {
      Get.snackbar("Xatolik", "Noto‘g‘ri kod. Qaytadan kiriting.");
    }
  }

  // 📌 Foydalanuvchini tekshirish
  Future<void> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasRegistered = prefs.getBool("hasRegistered") ?? false;

    if (_auth.currentUser != null || hasRegistered) {
      isAuthenticated.value = true;
    } else {
      isAuthenticated.value = false;
    }
  }

  // 📌 Foydalanuvchi sessiyasini saqlash
  Future<void> _saveUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasRegistered", true);
  }

  // 📌 Logout (Chiqish)
  Future<void> logout() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasRegistered", false);
    Get.offAll(() => RegisterPage());
  }
}
