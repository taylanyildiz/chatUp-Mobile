import 'package:chat_app/constants/constant.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    Key? key,
    required this.user,
    required this.currentUser,
    required this.index,
  }) : super(key: key);
  final User currentUser;
  final User user;
  final int index;
  @override
  Widget build(BuildContext context) {
    final isMe = user.messages[index].sender!.phone == currentUser.phone;
    final isRead = true;
    if (!isMe && !user.messages[index].isRead) {
      user.messages[index].isRead = true;
    }
    return Container(
      margin: EdgeInsets.only(
        right: !isMe ? 150.0 : 0.0,
        left: isMe ? 150.0 : 0.0,
        top: 10.0,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: isMe ? CustomColors.currentMessageBox : CustomColors.messageBox,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 10.0 : 0.0),
          topRight: Radius.circular(isMe ? 0.0 : 10.0),
          bottomLeft: Radius.circular(isMe ? 10.0 : 0.0),
          bottomRight: Radius.circular(isMe ? 0.0 : 10.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              user.messages[index].message!,
              style: TextStyle(
                color: isMe ? Colors.black : Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Text(
            '',
            style: TextStyle(
              color: isMe ? Colors.black : Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(width: 5.0),
          isMe
              ? Icon(
                  isRead ? Icons.done_all : Icons.done,
                  size: 15.0,
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
