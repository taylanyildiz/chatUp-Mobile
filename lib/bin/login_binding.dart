import '/controllers/controller.dart';
import 'package:get/get.dart';

class LoginBingin extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
