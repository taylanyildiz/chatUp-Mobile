import 'package:chat_app/routers/routers.dart';

import '/widgets/widget.dart';
import '/constants/constant.dart';
import '/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          color: CustomColors.chatBox,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) => NotificationListener<ScrollNotification>(
        onNotification: controller.onNotification,
        child: Scrollbar(
          child: GetBuilder<UserController>(
            builder: (userController) => ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: controller.scrollController,
              itemCount: userController.connectUser.length + 1,
              itemBuilder: (_, index) {
                if (index == 0) return _buildSerchBox(controller);
                return ChatProfileBox(
                  user: userController.connectUser[index - 1],
                  onDetail: () => Get.toNamed(
                    Routers.CHATDETAIL,
                    arguments: {
                      "userIndex": index - 1,
                      "user": userController.connectUser[index - 1],
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSerchBox(ChatController controller) {
    return SearchBox(opacity: controller.getOpacity(20));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: CustomColors.chatBox,
      centerTitle: true,
      title: Text(
        'Chats',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      leading: TextButton(
        onPressed: () {},
        child: Text(
          'Edit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.edit),
        ),
      ],
    );
  }
}
