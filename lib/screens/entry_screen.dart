import 'package:chat_app/constants/constant.dart';
import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/routers/routers.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryScreen extends GetView<EntryController> {
  EntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAppImage(),
          _buildExplain(),
          Spacer(),
          LogRegButton(
            onLogin: () => Get.toNamed(Routers.LOGIN),
            onRegister: () => Get.toNamed(Routers.REGISTER),
          ),
        ],
      ),
    );
  }

  Padding _buildExplain() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0),
      child: Column(
        children: [
          Text(
            'Enterprise team\ncollaboration.',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.3,
              wordSpacing: 3.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Bring together your files, your tools,\nprojects and people.Including a new\nmobile and desktop application',
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.3,
              color: CustomColors.hintColor,
              wordSpacing: 4.0,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildAppImage() {
    return Padding(
      padding: EdgeInsets.only(top: 60.0),
      child: Center(
        child: Image.asset(
          'assets/images/team_image.png',
          height: 300.0,
        ),
      ),
    );
  }
}
