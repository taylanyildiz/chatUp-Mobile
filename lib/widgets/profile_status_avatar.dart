import 'package:chat_app/constants/constant.dart';
import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileStatusAvatar extends StatelessWidget {
  ProfileStatusAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final isOnline = user.isOnline;
    return GetBuilder<UserController>(
      builder: (_) => Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.only(top: 10.0),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: Center(
                  child: Text(
                user.name!.characters.first,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
              radius: 35.0,
            ),
            Positioned(
              right: 5.0,
              bottom: 0.0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline
                      ? CustomColors.currentMessageBox
                      : Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
