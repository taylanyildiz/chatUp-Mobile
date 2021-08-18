import 'dart:developer';

import '/localization/translation.dart';
import '/routers/pages.dart';
import '/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/constant.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> with WidgetsBindingObserver {
  void initState() {
    super.initState();
    log('initState');
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    log('dispose');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // removed app
      log('detached');
    }
    if (state == AppLifecycleState.inactive) {
      // background app
      log('inactive');
    }
    if (state == AppLifecycleState.paused) {
      // background app
      // if platform is ios removed app build here
      log('paused');
    }
    if (state == AppLifecycleState.resumed) {
      // build again app
      // refres token
      log('resume');
      // Get.find<AuthService>().getAccountHash();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter CHAT APP',
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.scaffoldBackground,
        primaryColor: CustomColors.scaffoldBackground,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: CustomColors.headerColor,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            wordSpacing: 4.0,
          ),
          bodyText1: TextStyle(
            color: CustomColors.explainColor,
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
            wordSpacing: 4.0,
          ),
        ),
      ),
      locale: Get.locale ?? Locale('tr'),
      translations: Translation(),
      initialRoute: Routers.SPLASH,
      getPages: Pages.pages,
    );
  }
}
