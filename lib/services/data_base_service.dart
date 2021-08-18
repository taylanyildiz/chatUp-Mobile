import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/models/user.dart';
import 'package:get/get.dart';

class SecureStorage extends GetxController {
  User? currentUser;
  String? token;

  final storage = FlutterSecureStorage();

  @override
  void onInit() async {
    await getCurrentUser();
    super.onInit();
  }

  Future upateCurrentUser(User user, String token) async {
    final current = json.encode({"user": user.toJsonDb(), "token": token});
    await storage.write(key: 'current', value: current);
    update();
    getCurrentUser();
  }

  Future getCurrentUser() async {
    final current = await storage.read(key: 'current');
    if (current != null) {
      currentUser = User.fromJson(json.decode(current)['user']);
      token = json.decode(current)['token'];
    }
    update();
  }

  Future deleteCurrentUser() async {
    if (currentUser != null) {
      await storage.delete(key: 'current');
      currentUser = null;
      update();
    }
  }
}
