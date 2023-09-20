import 'dart:async';

import 'package:flutter_rust_bridge_template/models/wallet/wallets.dart';
import 'package:flutter_rust_bridge_template/utils/state/data_sp.dart';

import '../../../utils/route/app_navigator.dart';
import '/utils/log/logger.dart';
import 'package:get/get.dart';

class WalletLogic extends GetxController {
  late StreamSubscription initializedSub;

  late WalletRead selectedWallet;

  @override
  void onInit() {
    _loadStartData();
    selectedWallet = DataSp.selectedWalletRead;

    super.onInit();
  }

  _loadStartData() async {}

  @override
  void onClose() {
    initializedSub.cancel();
    super.onClose();
  }
}
