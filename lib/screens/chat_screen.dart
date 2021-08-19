import 'package:chat_app/routers/routers.dart';
import '/widgets/widget.dart';
import '/constants/constant.dart';
import '/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return GetBuilder<ChatController>(
      id: 'newMessage',
      builder: (controller) => SearchListView(
        itemCount: controller.users.length,
        builder: (context, index) {
          return _buildMessageProfileBox(controller, index);
        },
      ),
    );
  }

  InkWell _buildMessageProfileBox(ChatController controller, int index) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routers.CHATDETAIL,
        arguments: {'user': controller.users[index]},
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  controller.users[index].name!.characters.first.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.users[index].name! +
                      ' ' +
                      controller.users[index].lastName!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
