import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rust_bridge_template/utils/log/logger.dart';
// import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vara_sdk/api/types/networkParams.dart';
import 'package:vara_sdk/polkawallet_sdk.dart';
import 'package:vara_sdk/storage/keyring.dart';
import '../../models/wallet/wallet_types.dart';
import '../../models/wallet/wallets.dart';
import '../../models/wallet/wallets_group.dart';
import '../../models/wallet/wallets_group_read.dart';
import '../state/data_sp.dart';
import 'package:path_provider/path_provider.dart';

class Config {
  //初始化全局信息
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cachePath = (await getApplicationDocumentsDirectory()).path;
      await DataSp.init();
      await Hive.initFlutter(cachePath);

      await Hive.initFlutter();
      Hive.registerAdapter(TokenInfoAdapter());
      Hive.registerAdapter(WalletGroupAdapter());
      Hive.registerAdapter(WalletGroupReadAdapter());
      Hive.registerAdapter(WalletTypeAdapter());
      Hive.registerAdapter(WalletAdapter());
      Hive.registerAdapter(WalletReadAdapter());
    } catch (_) {}

    // init tdlib

    runApp();

    // screen dirction
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // systemUIOverlayStyle transparent（Android）
    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

    // FlutterBugly.init(androidAppId: "", iOSAppId: "");
  }

  static late String cachePath;
  static const uiW = 375.0;
  static const uiH = 812.0;

  /// 全局字体size
  static const double textScaleFactor = 1.0;

  /// 秘钥
  static const secret = 'tuoyun';

  static const mapKey = '';
}
