import 'dart:async';

import 'package:vara_sdk/api/types/networkParams.dart';
import 'package:vara_sdk/polkawallet_sdk.dart';
import 'package:vara_sdk/storage/keyring.dart';

import '../../utils/state/data_sp.dart';
import '/utils/route/app_navigator.dart';
import '/utils/log/logger.dart';
import 'package:get/get.dart';
// import 'package:openim_common/openim_common.dart';

// import '../../core/controller/im_controller.dart';
// import '../../core/controller/push_controller.dart';
// import '../../routes/app_navigator.dart';

class SplashLogic extends GetxController {
  // final imLogic = Get.find<IMController>();
  // final pushLogic = Get.find<PushController>();

  // String? get userID => DataSp.userID;
  // String? get token => DataSp.imToken;

  late StreamSubscription initializedSub;

  @override
  void onInit() {
    // initializedSub = imLogic.initializedSubject.listen((value) {
    //   LogUtil.debug('---------------------initialized---------------------');
    //   // if (null != userID && null != token) {
    //   //   _login();
    //   // } else {
    //   //   AppNavigator.startLogin();
    //   // }
    // });

    _loadStartData();

    super.onInit();
  }

  _loadStartData() async {
    // init polka api
    final WalletSDK sdk = WalletSDK();
    final Keyring keyring = Keyring();

    await keyring.init([137]);
    await sdk.init(keyring);

    DataSp.keyRing = keyring;
    DataSp.varaSdk = sdk;

    final node = NetworkParams();
    node.name = 'VARATest';
    node.endpoint = 'wss://testnet.vara.rs';
    // node.endpoint = 'wss://vit.vara-network.io';
    node.ss58 = 137;

    final _ = await DataSp.varaSdk.api.connectNode(DataSp.keyRing, [node]);

    // await Future.delayed(const Duration(seconds: 2));

    // is wallet exist
    // init rpc connection
    if (DataSp.getWalletGroupMaxID() > 0) {
      AppNavigator.homepage();
    } else {
      AppNavigator.startOnboarding();
    }
    // AppNavigator.startOnboarding();
  }

  // _login() async {
  //   try {
  //     Logger.print('---------login---------- userID: $userID, token: $token');
  //     await imLogic.login(userID!, token!);
  //     Logger.print('---------im login success-------');
  //     pushLogic.login(userID!);
  //     Logger.print('---------push login success----');
  //     AppNavigator.startSplashToMain(isAutoLogin: true);
  //   } catch (e, s) {
  //     IMViews.showToast('$e $s');
  //     await DataSp.removeLoginCertificate();
  //     AppNavigator.startLogin();
  //   }
  // }

  @override
  void onClose() {
    // initializedSub.cancel();
    super.onClose();
  }
}
