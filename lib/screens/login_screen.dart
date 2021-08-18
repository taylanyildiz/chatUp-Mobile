import 'package:chat_app/constants/constant.dart';
import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/routers/routers.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildHeader(),
            _buildExplain(context),
            _buildInputBox(),
            Spacer(),
            _buildToRegister(),
            _buildSignButton(),
          ],
        ),
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
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget _buildSignButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: SignButton(
          onTap: controller.onSign,
          controller: controller.singButtonController,
          width: 300.0,
          height: 60.0,
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToRegister() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "Don't have an account ? ",
            style: TextStyle(
              color: CustomColors.explainColor,
              fontSize: 17.0,
              wordSpacing: 3.0,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: CustomColors.headerColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.offAndToNamed(Routers.REGISTER),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplain(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Let's sign you in"),
          Text(
            "Welcome back",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "You've been missed",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox() {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            LogInputBox(
              textController: controller.phoneController,
              padding: 20.0,
              type: TextInputType.phone,
              suffixIcon: Icons.phone,
              hint: 'Enter your phone',
            ),
            LogInputBox(
              textController: controller.passwordController,
              isPassword: true,
              padding: 20.0,
              suffixIcon: Icons.lock,
              hint: 'Enter your password',
            ),
          ],
        ),
      ),
    );
  }
}
