import 'package:get/get.dart';
import '/controllers/controller.dart';

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatDetailController());
  }
}
