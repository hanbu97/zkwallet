import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    runApp();
  }

  static late String cachePath;
  static const uiW = 375.0;
  static const uiH = 812.0;

  /// 全局字体size
  static const double textScaleFactor = 1.0;
}
