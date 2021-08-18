import 'package:chat_app/services/service.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  /// login button controller
  SingButtonController singButtonController = SingButtonController();

  late TextEditingController phoneController;
  late TextEditingController passwordController;

  late GlobalKey<FormState> formKey;

  late String phone;
  late String password;

  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  void onSign() async {
    if (formKey.currentState!.validate()) {
      phone = phoneController.text;
      password = passwordController.text;
      authService.getAccount(phone, password);
    } else {
      Utils.showSnacBar('Input Check', 'Please input name and password');
      await Future.delayed(Duration(seconds: 1), () {
        singButtonController.stop();
      });
    }
  }
}
