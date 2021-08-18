import '/bin/bin.dart';
import '/routers/routers.dart';
import '/screens/screens.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static final pages = <GetPage>[
    GetPage(
      name: Routers.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routers.ENTRY,
      page: () => EntryScreen(),
      binding: LoginBingin(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routers.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBingin(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routers.REGISTER,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: Routers.NAV,
      page: () => NavScreen(),
      binding: NavBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routers.DIRECTORY,
      page: () => DirectoryScreen(),
      binding: DirectoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routers.CAMERA,
      page: () => CameraScreen(),
      binding: CameraBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routers.CHAT,
      page: () => ChatScreen(),
      binding: ChatBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routers.SETTING,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routers.CHATDETAIL,
      page: () => ChatDetailScreen(),
      binding: ChatDetailBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
