import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../pages/auth/otp_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/mani/home_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  var errorMessage = ''.obs; // 🔹 Xatolik xabarini GetX bilan boshqarish

  Future<void> login(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offAll(() => HomePage());
        },
        verificationFailed: (FirebaseAuthException e) {
          errorMessage.value = e.message ?? "Noma’lum xatolik"; // 🔹 Xatolikni ekranga chiqarish
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.to(() => OTPPage(phoneNumber: phoneNumber));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      errorMessage.value = "Kirishda xatolik: $e";
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential =
      PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp);
      await _auth.signInWithCredential(credential);
      Get.offAll(() => HomePage());
    } catch (e) {
      errorMessage.value = "Kiritilgan kod noto‘g‘ri"; // 🔹 Xatolik xabari
    }
  }

  Future<void> registerUser(String name, String phone, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: "$phone@example.com", // Firebase email format talab qiladi
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        Get.offAll(() => HomePage());
      }
    } catch (e) {
      errorMessage.value = "Ro‘yxatdan o‘tishda xatolik: $e";
    }
  }

  // 🔹 Chiqish funksiyasi
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => LoginPage()); // 🔹 Login sahifasiga qaytarish
  }
}
