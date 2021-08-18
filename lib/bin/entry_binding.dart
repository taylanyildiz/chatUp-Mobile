import '/controllers/controller.dart';
import 'package:get/get.dart';

class EntryBingin extends Bindings {
  @override
  void dependencies() {
    Get.put(EntryController());
  }
}
