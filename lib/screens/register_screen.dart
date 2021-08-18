import 'package:chat_app/routers/routers.dart';
import 'package:flutter/services.dart';

import '/constants/constant.dart';
import '/controllers/controller.dart';
import '/widgets/widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<RegisterController>(
          builder: (_) => Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: [
                        _LogPerson(),
                        _LogPassword(),
                        _SelectProfilePhoto()
                      ],
                      onPageChanged: controller.onPageChanged,
                    ),
                  ),
                  _buildToLogin(),
                  _buildSignUpButton(),
                ],
              ),
              _buildTermOfUse(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: BarButton(
        width: Get.width * .8,
        backgroundColor: Colors.white,
        child: Center(
          child: Text(
            controller.signButtonText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: controller.onSign,
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 60.0),
      child: Row(
        children: [
          BarButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.arrow_back),
            onPressed: controller.onBack,
          ),
          SizedBox(width: 30.0),
          Text(
            'Sign UP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermOfUse() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 300.0,
      child: Opacity(
        opacity: (1 - controller.page).clamp(0.0, 1.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'By registering, you accept the  ',
                  style: TextStyle(
                    color: CustomColors.hintColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'terms of use.',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => print('Term of Use'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToLogin() {
    return Opacity(
      opacity:
          controller.page > 1 ? (2 - controller.page).clamp(0.0, 1.0) : 1.0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have an account\t\t\t',
                style: TextStyle(
                  color: CustomColors.hintColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.offAndToNamed(Routers.LOGIN),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogPerson extends GetView<RegisterController> {
  const _LogPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildInput(),
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Form(
        key: controller.formKeyPerson,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogInputBox(
              textController: controller.nameController,
              maxLine: 15,
              padding: 20.0,
              hint: 'Enter your name',
              suffixIcon: Icons.person,
            ),
            LogInputBox(
              textController: controller.lastNameController,
              maxLine: 15,
              padding: 20.0,
              hint: 'Enter your last name',
              suffixIcon: Icons.person,
            ),
            LogInputBox(
              textController: controller.phoneController,
              type: TextInputType.phone,
              maxLine: 15,
              padding: 20.0,
              hint: 'Enter your phone number',
              suffixIcon: Icons.phone,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogPassword extends GetView<RegisterController> {
  _LogPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildInput(),
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: Form(
        key: controller.formKeyPassword,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogInputBox(
              textController: controller.passController,
              type: TextInputType.visiblePassword,
              maxLine: 15,
              padding: 20.0,
              hint: 'Enter Strong password',
              suffixIcon: Icons.lock,
              isPassword: true,
            ),
            LogInputBox(
              textController: controller.veriyfPassController,
              type: TextInputType.visiblePassword,
              maxLine: 15,
              padding: 20.0,
              hint: 'Enter password again',
              suffixIcon: Icons.lock,
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectProfilePhoto extends GetView<RegisterController> {
  const _SelectProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SelectProfilePhoto(
              onPressed: (file) {},
              profileImage: controller.profileImage ?? null,
              onDelete: () {},
            ),
          ],
        ),
      ),
    );
  }

  Transform _buildHeader() {
    return Transform.translate(
      offset: Offset(
        2 * controller.offset * (2 - controller.page),
        0.0,
      ),
      child: Text(
        'Select Profile Photo',
        style: TextStyle(
          color: CustomColors.hintColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
