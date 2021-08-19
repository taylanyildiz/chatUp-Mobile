import 'package:chat_app/controllers/controller.dart';

import '/models/message.dart';
import '/models/user.dart';
import '/services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  User? currentUser;
  String? token;

  List<User> connectUser = [];

  final secureStorage = Get.find<SecureStorage>();

  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();
    currentUser = secureStorage.currentUser;
    token = secureStorage.token;
    super.onInit();
  }

  void updateCurrentUser(User user, String token) {
    currentUser = user;
    this.token = token;
    secureStorage.upateCurrentUser(user, token);
    update();
  }

  Future deleteCurrentUser() async {
    await secureStorage.deleteCurrentUser();
    await getCurrentUser();
  }

  Future getCurrentUser() async {
    await secureStorage.getCurrentUser();
    currentUser = secureStorage.currentUser;
    token = secureStorage.token;
    update();
  }

  void addConnectUser(User user) {
    int index = connectUser.indexWhere((u) => u.phone == user.phone);
    if (index == -1) {
      connectUser.add(user);
    } else {
      connectUser[index].isOnline = true;
    }
    update();
  }

  void setUserConnectionStatus(User user) {
    int index = connectUser.indexWhere((con) => user.phone == con.phone);
    if (index != -1) {
      connectUser[index].isOnline = false;
      update();
    }
  }

  void setTyping(User user, bool status) {
    int index = connectUser.indexWhere((con) => con.phone == user.phone);
    if (index != -1) {
      connectUser[index].typing = status;
      update();
    }
  }

  void addMessage(Message message) {
    final sender = message.sender;
    final receiver = message.receiver;
    int index = connectUser.indexWhere(
        (u) => u.phone == sender!.phone || u.phone == receiver!.phone);
    if (index != -1) {
      connectUser[index].messages.add(message);
      // if (index != 0) {
      //   final lastMessage = connectUser.removeAt(index);
      //   connectUser.insert(0, lastMessage);
      // }
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      Get.find<ChatController>().addUserMessage(connectUser[index]);
      update(['message']);
    }
  }
}
