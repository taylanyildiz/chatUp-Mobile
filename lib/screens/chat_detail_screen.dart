import 'package:chat_app/constants/constant.dart';
import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/widgets/bar_button.dart';
import 'package:chat_app/widgets/input_message.dart';
import 'package:chat_app/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailScreen extends GetView<ChatDetailController> {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildMessageList(),
            _buildInputMessageBox()
          ],
        ),
      ),
    );
  }

  InputMessage _buildInputMessageBox() {
    return InputMessage(
      marginBottom: 15.0,
      textController: controller.messageController,
      onChanded: controller.onChanged,
      onSend: controller.sendMessage,
      onAdd: () {},
    );
  }

  GetBuilder<UserController> _buildMessageList() {
    return GetBuilder<UserController>(
      id: 'message',
      builder: (userController) {
        final currentUser = userController.currentUser;
        final _user = controller.user;
        int index = userController.connectUser
            .indexWhere((element) => element.phone == _user.phone);
        final user = userController.connectUser[index];
        return Expanded(
          child: ListView.builder(
            controller: userController.scrollController,
            itemCount: user.messages.length + 1,
            itemBuilder: (context, index) {
              if (index == user.messages.length) return SizedBox(height: 60.0);
              return MessageBox(
                user: user,
                currentUser: currentUser!,
                index: index,
              );
            },
          ),
        );
      },
    );
  }

  Container _buildAppBar() {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: CustomColors.headerColor,
        ),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarButton(
            width: 50.0,
            height: 50.0,
            onPressed: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          _buildCircleAvatar(),
          SizedBox(width: 15.0),
          _buildUserName()
        ],
      ),
    );
  }

  Container _buildCircleAvatar() {
    return Container(
      width: 50.0,
      height: 50.0,
      margin: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          controller.user.name!.characters.first,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  Expanded _buildUserName() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.user.name! + ' ' + controller.user.lastName!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 5.0),
          _buildUserStatus(),
        ],
      ),
    );
  }

  Widget _buildUserStatus() {
    return GetBuilder<UserController>(
      builder: (userController) {
        final currentUser = userController.currentUser;
        final _user = controller.user;
        int index = userController.connectUser
            .indexWhere((element) => element.phone == _user.phone);
        final user = userController.connectUser[index];
        return Text(
          user.isOnline
              ? user.typing
                  ? 'typing..'
                  : 'online'
              : 'offline',
          style: TextStyle(
            color: CustomColors.hintColor,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
        );
      },
    );
  }
}
