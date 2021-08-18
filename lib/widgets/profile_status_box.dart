import '/models/user.dart';
import '/constants/constant.dart';
import 'package:flutter/material.dart';
import 'profile_status_avatar.dart';

class ProfileStatusBox extends StatelessWidget {
  ProfileStatusBox({
    Key? key,
    required this.user,
    this.padding,
  }) : super(key: key);

  final double? padding;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: padding ?? 20.0,
        right: padding ?? 20.0,
        top: (padding ?? 20.0) + 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileStatusAvatar(user: user),
          SizedBox(width: 10.0),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name! + ' ' + user.lastName!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  user.isOnline
                      ? user.typing
                          ? 'typing..'
                          : 'online'
                      : 'offline',
                  style: TextStyle(
                    color: CustomColors.hintColor,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
            color: Colors.white,
            iconSize: 30.0,
          ),
        ],
      ),
    );
  }
}
