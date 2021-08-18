import 'package:chat_app/screens/camera_screen.dart';

import '/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  int currentPage = 0;

  final pages = <Widget>[
    DirectoryScreen(),
    CameraScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void onPageChange(int page) {
    currentPage = page;
    update();
  }
}
