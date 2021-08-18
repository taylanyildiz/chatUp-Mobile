import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.currentMessageBox,
          ),
          child: Center(
            child: Icon(
              Icons.question_answer,
              color: Colors.black,
              size: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}
