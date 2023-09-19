part of 'app_pages.dart';

abstract class AppRoutes {
  // static const notFound = '/not-found';
  static const splash = '/splash';
  static const onBoarding = '/onBoarding';

  // wallet
  static const newWallet = '/newWallet';

  // home
  static const home = '/home';
}

extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}
