import 'languages/en.dart';
import 'languages/tr.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'tr': tr,
      };
}
