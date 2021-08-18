import 'dart:developer';
import '/controllers/controller.dart';
import '/widgets/widget.dart';
import '/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends GetView<ChatDetailController> {
  ChatDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.chatScaffold,
        appBar: _buildAppBar(),
        body: ChatBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileBox(),
              _buildMessageBox(isKeyboard),
              _buildInputMessageBox()
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: CustomColors.chatScaffold,
      leading: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          color: CustomColors.messageBox,
          onPressed: () => Get.back(),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: CustomColors.chatBox,
          ),
        ),
      ],
      title: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          'Chat with',
          style: TextStyle(
            color: CustomColors.chatBox,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProfileBox() {
    return GetBuilder<UserController>(
      builder: (userController) => ProfileStatusBox(
        user: userController.connectUser[controller.userIndex],
      ),
    );
  }

  Widget _buildMessageBox(isKeyboard) {
    return GetBuilder<UserController>(
      id: controller.userIndex,
      builder: (userController) => Expanded(
        child: Scrollbar(
          controller: userController.scrollController,
          child: ListView.builder(
            controller: userController.scrollController,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            itemCount: userController
                    .connectUser[controller.userIndex].messages.length +
                1,
            itemBuilder: (_, index) {
              if (index ==
                  userController
                      .connectUser[controller.userIndex].messages.length)
                return SizedBox(
                  height: isKeyboard ? 60 : 0,
                  width: Get.width,
                );
              return MessageBox(
                index: index,
                user: userController.connectUser[controller.userIndex],
                currentUser: userController.currentUser!,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputMessageBox() {
    return GetBuilder<UserController>(
      builder: (userController) => InputMessage(
        onChanded: controller.onChanged,
        onSend: controller.sendMessage,
        onAdd: () {
          log('message');
        },
      ),
    );
  }
}
