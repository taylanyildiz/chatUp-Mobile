import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavScreen extends GetView<NavController> {
  NavScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      builder: (_) => Scaffold(
        body: controller.pages[controller.currentPage],
        bottomNavigationBar: CustomBottomNav(
          onPress: controller.onPageChange,
          selectColor: Colors.black,
          color: Colors.grey,
          initialIndex: controller.currentPage,
          items: [
            CustomBarItem(Icons.account_circle),
            CustomBarItem(Icons.file_copy_outlined),
            CustomBarItem(Icons.message),
            CustomBarItem(Icons.settings),
          ],
        ),
      ),
    );
  }
}
