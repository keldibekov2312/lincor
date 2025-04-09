import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: "+998");
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ro‘yxatdan o‘tish")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Ism"),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Telefon raqam"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Parol"),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Parolni takrorlang"),
            ),
            SizedBox(height: 10),
            Obx(() => Text(
              authController.errorMessage.value,
              style: TextStyle(color: Colors.red),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text.length < 8) {
                  authController.errorMessage.value = "Parol 8 ta belgidan kam bo‘lmasin";
                  return;
                }
                if (passwordController.text != confirmPasswordController.text) {
                  authController.errorMessage.value = "Parollar mos kelmadi";
                  return;
                }
                authController.registerUser(
                  nameController.text.trim(),
                  phoneController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text("Ro‘yxatdan o‘tish"),
            ),
          ],
        ),
      ),
    );
  }
}
