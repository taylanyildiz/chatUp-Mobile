import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user.dart';
import '/services/service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  User? currentUser;
  String? token;

  List<User> connectUser = [];

  final secureStorage = Get.find<SecureStorage>();

  @override
  void onInit() {
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
      connectUser[index] = user;
    }
    update();
  }

  void setTyping(User user) {
    int index =
        connectUser.indexWhere((element) => element.phone == user.phone);
    if (index != -1) {
      connectUser[index] = user;
      update([index]);
    }
  }

  void addMessage(Message message) {
    final sender = message.sender;
    final receiver = message.receiver;
    int index = connectUser.indexWhere(
        (u) => u.phone == sender!.phone || u.phone == receiver!.phone);
    if (index != -1) {
      connectUser[index].messages.add(message);
      update([connectUser[index].phone!]);
    }
  }
}
