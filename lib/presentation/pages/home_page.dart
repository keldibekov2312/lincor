import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/aoth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // bu appBarni pastgi qismiga radius beradi
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: Container(
          height: 300, // Balandlikni o'zgartirish
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            // Chap va yuqoriga surish
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Salom, Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "LinCor bilan birga bo'lin",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
                // Avatar qo'shish
                Container(
                  width: 36, // Avatarning eni
                  height: 57, // Avatarning bo‘yi
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // Yengil burchaklari yumaloq bo‘lishi uchun
                    image: DecorationImage(
                      image: AssetImage('assets/images/Avatar.png'),
                      // Avatar rasmi
                      fit: BoxFit.cover, // Rasmni to‘liq ko‘rsatish
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200); // Custom AppBar balandligi
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyCustomAppBar(), body: Column());
  }
}
