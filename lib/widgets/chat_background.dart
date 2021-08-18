import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';

class ChatBackground extends StatelessWidget {
  ChatBackground({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        color: CustomColors.messageListBox,
      ),
      child: child,
    );
  }
}
