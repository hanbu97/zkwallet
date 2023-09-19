import 'package:get/get.dart';
import 'app_pages.dart';

class AppNavigator {
  AppNavigator._();

  static void startOnboarding() {
    Get.offAllNamed(AppRoutes.onBoarding);
    // Get.to(Get.to(TgTestScreen()));
  }

  // static void newWallet() {
  //   Get.offAllNamed(AppRoutes.newWallet);
  // }

  // static void homepage() {
  //   Get.offAllNamed(AppRoutes.home);
  // }
}
