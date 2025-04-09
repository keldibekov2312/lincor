import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bosh sahifa"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authController.logout(); // 🔹 Logout tugmasi to‘g‘ri ishlaydi
            },
          )
        ],
      ),
      body: Center(
        child: user != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Xush kelibsiz, ${user.displayName ?? "Foydalanuvchi"}!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Telefon raqam: ${user.email?.replaceAll("@example.com", "") ?? "Noma'lum"}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.logout();
              },
              child: Text("Chiqish"),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
