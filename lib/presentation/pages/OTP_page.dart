import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/aoth_controller.dart';

class OTPVerificationPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController otpController = TextEditingController();
  final String phoneNumber;

  OTPVerificationPage({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Tasdiqlash")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("SMS kodni kiriting:"),
            TextField(controller: otpController, keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.verifyOTP(otpController.text.trim());
              },
              child: Text("Tasdiqlash"),
            ),
          ],
        ),
      ),
    );
  }
}
