import 'package:flutter_rust_bridge_template/screens/home/main/binding.dart';
import 'package:flutter_rust_bridge_template/screens/home/main/screen.dart';
import 'package:flutter_rust_bridge_template/screens/onboarding/binding.dart';
import 'package:flutter_rust_bridge_template/screens/onboarding/screen.dart';
import 'package:get/get.dart';

import '../../screens/splash/binding.dart';
import '../../screens/splash/screen.dart';
import '../../screens/wallet/create_import/binding.dart';
import '../../screens/wallet/create_import/screen.dart';
part 'app_routes.dart';

class AppPages {
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: true,
      );

  static final routes = <GetPage>[
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.onBoarding,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.newWallet,
      page: () => NewWalletPage(),
      binding: NewWalletBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
