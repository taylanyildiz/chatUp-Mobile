import '/controllers/controller.dart';
import 'package:get/get.dart';

class NavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavController());
    Get.put(DirectroyController());
    Get.put(ChatController());
  }
}
