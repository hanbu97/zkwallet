import 'dart:async';

import '/utils/route/app_navigator.dart';
import '/utils/state/data_sp.dart';

import '/utils/log/logger.dart';
import 'package:get/get.dart';

class OnboardingLogic extends GetxController {
  late StreamSubscription initializedSub;

  @override
  void onInit() {
    _loadStartData();

    super.onInit();
  }

  _loadStartData() async {
    await Future.delayed(const Duration(seconds: 2));

    // AppNavigator.startOnboarding();
  }

  @override
  void onClose() {
    initializedSub.cancel();
    super.onClose();
  }
}
