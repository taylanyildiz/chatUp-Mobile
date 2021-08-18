import '/routers/routers.dart';
import '/services/service.dart';
import '/controllers/controller.dart';
import '/models/user.dart';
import '/utils/utils.dart';
import '/constants/constant.dart';
import 'package:get/get.dart';

class AuthService extends GetConnect {
  final userController = Get.find<UserController>();
  final secureStorage = Get.find<SecureStorage>();
  final socketService = Get.find<SocketService>();

  @override
  void onInit() {
    baseUrl = RestfulConstant.REMOTE_BASE_URL;
    super.onInit();
  }

  Future createAccount(User user) async {
    final url = RestfulConstant.CREATE_ACCOUNT;
    Response response = await post(url, {'user': user.toJsonDb()});
    if (response.statusCode == 200) {
      final user = User.fromJson(response.body['user']);
      final token = response.body['token'];
      userController.updateCurrentUser(user, token);
      socketService.onConnect(token);
      Get.offAndToNamed(Routers.NAV);
    } else {
      Utils.showSnacBar('Create Account', 'Error');
    }
  }

  Future getAccount(String phone, String password) async {
    final url = RestfulConstant.GET_ACCOUNT;
    Response response = await post(url, {"phone": phone, "password": password});
    if (response.statusCode == 200) {
      final user = User.fromJson(response.body['user']);
      final token = response.body['token'];
      userController.updateCurrentUser(user, token);
      socketService.onConnect(token);
      Get.offAllNamed(Routers.NAV);
      return;
    }
    if (response.statusCode == 400) {
      // user not found
      await userController.deleteCurrentUser();
      return;
    }
  }

  Future getAccountHash() async {
    final url = RestfulConstant.GET_ACCOUNT_HASH;
    if (secureStorage.currentUser != null && secureStorage.token != null) {
      Response response = await post(url, {
        "phone": secureStorage.currentUser!.phone,
        "password": secureStorage.currentUser!.password,
      }, headers: {
        "x-access-token": secureStorage.token!
      });
      if (response.statusCode == 200) {
        final user = User.fromJson(response.body['user']);
        final token = response.body['token'];
        userController.updateCurrentUser(user, token);
        socketService.onConnect(token);
        Get.offAndToNamed(Routers.NAV);
        return;
      }
      if (response.statusCode == 400) {
        // auth token error
        await userController.deleteCurrentUser();
        return;
      }
      Get.offAllNamed(Routers.ENTRY);
      if (response.statusCode == 401) {
        // no token provided
        await userController.deleteCurrentUser();
        Get.offAllNamed(Routers.ENTRY);
        return;
      }

      if (response.statusCode == 402) {
        // user not found
        await userController.deleteCurrentUser();
        Get.offAllNamed(Routers.ENTRY);
        return;
      }

      if (response.statusCode == 403) {
        // query error
        await userController.deleteCurrentUser();
        Get.offAllNamed(Routers.ENTRY);
        return;
      }
    } else {
      Get.offAllNamed(Routers.ENTRY);
      return;
    }
  }
}
