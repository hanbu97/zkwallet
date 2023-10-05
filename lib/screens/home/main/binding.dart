import '/screens/home/wallet/logic.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeBinding());
    Get.lazyPut(() => WalletLogic());
  }
}
