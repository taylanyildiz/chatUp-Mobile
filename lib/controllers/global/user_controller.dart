import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import '/services/service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  User? currentUser;
  String? token;

  List<User> connectUser = [];

  final secureStorage = Get.find<SecureStorage>();

  late ScrollController scrollController;

  late FocusNode focusNode;

  @override
  void onInit() {
    scrollController = ScrollController();
    focusNode = FocusNode();
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

  void addUpdateConnectUser(User user, {bool? isOnline}) {
    int index = connectUser.indexWhere((u) => u.phone == user.phone);
    if (isOnline == null) {
      if (index == -1) {
        connectUser.add(user);
      } else {
        connectUser[index].isOnline = true;
      }
    } else {
      connectUser[index].isOnline = isOnline;
    }
    update();
  }

  void setTyping(User user, bool status) {
    int index =
        connectUser.indexWhere((element) => element.phone == user.phone);
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
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      update([index]);
    }
  }
}
