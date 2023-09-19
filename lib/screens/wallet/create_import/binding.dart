import 'package:get/get.dart';

import 'logic.dart';

class NewWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewWalletBinding());
  }
}
