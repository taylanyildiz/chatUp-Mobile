import 'package:chat_app/constants/constant.dart';
import 'package:flutter/material.dart';

class LoadinDialog extends StatefulWidget {
  LoadinDialog({Key? key}) : super(key: key);

  @override
  _LoadinDialogState createState() => _LoadinDialogState();
}

class _LoadinDialogState extends State<LoadinDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.black26,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.unReadBox,
        ),
        child: Icon(
          Icons.question_answer,
          color: Colors.white,
        ),
      ),
    );
  }
}
