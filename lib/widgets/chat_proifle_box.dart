import '/models/user.dart';
import '/widgets/widget.dart';
import '/constants/constant.dart';
import 'package:flutter/material.dart';

class ChatProfileBox extends StatelessWidget {
  ChatProfileBox({
    Key? key,
    required this.user,
    required this.onDetail,
  }) : super(key: key);

  final Function() onDetail;
  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetail,
      child: Container(
        height: 80.0,
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          color: CustomColors.scaffoldBackground,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileStatusAvatar(user: user),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildName(),
                              _buildLastMessage(),
                            ],
                          ),
                        ),
                        _buildCreatedAt()
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 1.0,
                      color: CustomColors.chatBox,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildCreatedAt() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Text(
          '23.04.12',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: CustomColors.hintColor,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  Padding _buildLastMessage() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Text(
        '',
        style: TextStyle(
          color: CustomColors.hintColor,
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Padding _buildName() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        user.name! + ' ' + user.lastName!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 17.0,
        ),
      ),
    );
  }
}
