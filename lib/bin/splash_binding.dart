import '/services/service.dart';
import '/controllers/controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SecureStorage(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(SocketService(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(SplashController());
  }
}
