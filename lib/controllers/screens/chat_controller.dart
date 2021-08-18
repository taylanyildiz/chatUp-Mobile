import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late ScrollController scrollController;
  double opacity = 0;
  double anim = 1.0;

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(update);
    super.onInit();
  }

  bool onNotification(scrollState) {
    if (scrollState is ScrollEndNotification &&
        (scrollState.metrics.pixels >= 0 && scrollState.metrics.pixels < 25)) {
      Future.delayed(const Duration(milliseconds: 100), () {}).then((s) {
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      });
    }
    if (scrollState is ScrollEndNotification &&
        (scrollState.metrics.pixels >= 25 &&
            scrollState.metrics.pixels <= 50)) {
      Future.delayed(const Duration(milliseconds: 100), () {}).then((s) {
        scrollController.animateTo(50,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      });
    }
    return false;
  }

  double getPosition(double height, int index, int totalCount) {
    if (scrollController.hasClients) {
      final itemPositionOffset = totalCount * index;
      final difference = scrollController.offset - itemPositionOffset;
      final percent = 1 - (difference / height);
      anim = percent;
      if (percent > 1.0) anim = 1.0;
      if (percent <= 0.0) anim = 0.0;
    }
    return anim;
  }

  double getOpacity(int totalCount) {
    opacity = getPosition(20.0, 0, totalCount);
    return opacity;
  }
}
