import 'dart:async';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  late User user;

  late TextEditingController messageController;
  Timer? timer;

  final socketService = Get.find<SocketService>();

  @override
  void onInit() {
    messageController = TextEditingController();
    user = Get.arguments['user'];
    super.onInit();
  }

  void onChanged(String? input) {
    if (timer != null) {
      timer!.cancel();
    }
    socketService.setTyping(user, true);
    timer = Timer(Duration(milliseconds: 500), () {
      socketService.setTyping(user, false);
    });
  }

  void sendMessage(String message) => socketService.sendMessage(user, message);
}
