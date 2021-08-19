import 'dart:developer';

import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/models/user.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final List<User> users = [];

  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
  }

  void addUserMessage(User user) {
    int index = users.indexWhere((element) => element.phone == user.phone);
    if (index == -1) {
      users.insert(0, user);
    } else {
      log('message');
      final lastMessage = users.removeAt(index);
      users.insert(0, lastMessage);
    }
    update(['newMessage']);
  }
}
