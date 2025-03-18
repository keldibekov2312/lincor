import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/aoth_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController authController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ro'yhatdan o'tish"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Ism")),
            TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: "Telefon raqami")),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Parol")),
            TextField(controller: confirmPasswordController, obscureText: true, decoration: InputDecoration(labelText: "Parolni qaytadan kiriting")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text == confirmPasswordController.text) {
                  authController.registerUser(phoneController.text.trim());
                } else {
                  Get.snackbar("Xatolik", "Parollar mos kelmadi!");
                }
              },
              child: Text("Ro'yhatdan o'tish"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
