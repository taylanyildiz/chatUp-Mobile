import '/routers/routers.dart';
import '/services/service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final authService = Get.find<AuthService>();
  final secureStorage = Get.find<SecureStorage>();

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (secureStorage.currentUser == null) {
        Get.offAndToNamed(Routers.ENTRY);
      } else {
        authService.getAccountHash();
      }
    });
    super.onInit();
  }
}
