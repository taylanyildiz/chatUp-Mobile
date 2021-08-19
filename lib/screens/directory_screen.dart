import 'package:chat_app/constants/constant.dart';
import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/routers/routers.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectoryScreen extends GetView<DirectroyController> {
  DirectoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(),
        floatingActionButton: _buildFloatingAddButton(),
        body: GetBuilder<UserController>(
          builder: (userController) => SearchListView(
            itemCount: userController.connectUser.length,
            builder: (context, index) {
              final user = userController.connectUser[index];
              return _buildProfileBox(user, index);
            },
          ),
        ),
      ),
    );
  }

  InkWell _buildProfileBox(User user, int index) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.white,
      onTap: () => Get.toNamed(
        Routers.CHATDETAIL,
        arguments: {'user': user},
      ),
      child: Container(
        color: CustomColors.scaffoldBackground,
        height: 70.0,
        margin: EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCircleAvatar(user, index),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    user.lastSeen.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildCircleAvatar(User user, int index) {
    return Container(
      height: 60.0,
      width: 60.0,
      margin: EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          user.name!.characters.first.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: CustomColors.chatBox,
      title: Text(
        'Users',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingAddButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: CustomColors.unReadBox,
      onPressed: () {},
    );
  }
}
