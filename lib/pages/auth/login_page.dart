import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'otp_page.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kirish")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Telefon raqam (+998...)"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Parol"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(phoneController.text.trim());
              },
              child: Text("Kirish"),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed("/register");
              },
              child: Text("Ro‘yxatdan o‘tish"),
            )
          ],
        ),
      ),
    );
  }
}
