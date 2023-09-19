// import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
// import '/models/login_certificate.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import '../config/config.dart';
import 'sp_util.dart';

class DataSp {
  static const _toplinkKey = 'toplink';

  // data key

  static const _loginCertificate = 'loginCertificate';
  // read only, no sensitive info
  static const _walletGroupRead = '%s_walletGroupRead';

  // managers

  DataSp._();

  static init() async {
    await SpUtil().init();
  }

  static String getKey(String key) {
    // return sprintf(key, [OpenIM.iMManager.userID]);
    return sprintf(key, [_toplinkKey]);
  }

  static List<String> get walletGroupRead => getWalletGroupRead() ?? [];
  // wallet group read
  static List<String>? getWalletGroupRead() {
    return SpUtil().getObj(_walletGroupRead, (v) => []);
  }
}
