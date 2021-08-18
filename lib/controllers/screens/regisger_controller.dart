import 'package:chat_app/models/user.dart';

import '/services/service.dart';
import '/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late PageController pageController;

  late GlobalKey<FormState> formKeyPerson;
  late GlobalKey<FormState> formKeyPassword;
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController passController;
  late TextEditingController veriyfPassController;

  late String password;
  late String verifyPassword;
  late String name;
  late String phone;
  late String lastname;
  Image? profileImage;

  int currentPage = 0;
  double page = 0.0;
  double offset = 0.0;

  String signButtonText = 'Next';

  // restful service
  final restfulService = Get.find<AuthService>();

  @override
  void onInit() {
    formKeyPerson = GlobalKey();
    formKeyPassword = GlobalKey();
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    passController = TextEditingController();
    veriyfPassController = TextEditingController();
    pageController = PageController()..addListener(_pageListener);
    super.onInit();
  }

  void _pageListener() {
    if (pageController.position.hasContentDimensions) {
      page = pageController.page ?? 0.0;
      offset = pageController.offset;
    }
    update();
  }

  void onPageChanged(int page) {
    this.currentPage = page;
    if (currentPage == 2) {
      signButtonText = 'Ready';
    } else {
      signButtonText = 'Next';
    }
  }

  void onSign() {
    if (currentPage == 0) {
      if (formKeyPerson.currentState!.validate()) {
        name = nameController.text;
        lastname = lastNameController.text;
        phone = phoneController.text;
        if (GetUtils.isUsername(name) &&
            GetUtils.isUsername(lastname) &&
            GetUtils.isPhoneNumber(phone)) {
          pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else
          Utils.showSnacBar('Input Check', 'Please Check out input box');
      } else {
        Utils.showSnacBar('Input Check', 'Please Check out input box');
      }
    } else if (currentPage == 1) {
      if (formKeyPassword.currentState!.validate()) {
        password = passController.text;
        verifyPassword = veriyfPassController.text;
        if (password.length >= 6 && verifyPassword.length >= 6) {
          if (password == verifyPassword) {
            pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          } else
            Utils.showSnacBar('Password Match', 'Passwords do not match');
        } else
          Utils.showSnacBar('Password Invalid', 'Invalid password');
      } else
        Utils.showSnacBar('Input Check', 'Please Check out input box');
    } else if (currentPage == 2) {
      _createAnAccount();
    }
  }

  void onBack() {
    if (currentPage == 0)
      Get.back();
    else
      pageController.animateToPage(
        --currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
  }

  void _createAnAccount() async {
    final currentUser = User(
      name: name,
      lastName: lastname,
      phone: phone,
      password: password,
    );
    await restfulService.createAccount(currentUser);
  }
}
