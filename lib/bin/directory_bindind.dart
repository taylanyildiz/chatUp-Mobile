import '/controllers/controller.dart';
import 'package:get/get.dart';

class DirectoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DirectroyController());
  }
}
