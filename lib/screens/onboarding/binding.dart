import 'package:get/get.dart';

import 'logic.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingLogic());
  }
}
