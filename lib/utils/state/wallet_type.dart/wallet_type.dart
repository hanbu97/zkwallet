import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waterspay/chains/config.dart';
import 'package:waterspay/models/wallet/wallet_types.dart';
import 'package:waterspay/utils/log/logger.dart';

class WalletTypeSp {
  static final WalletTypeSp _singleton = WalletTypeSp._internal();
  factory WalletTypeSp() {
    return _singleton;
  }
  WalletTypeSp._internal();

  static const _walletKey = '_WalletTypeSp';
  static late GetStorage _storage;

  static const _walletTypes = "_walletTypes";
  static const _walletTypesList = "_walletTypes"; // selected wallet type list
  static const _currentWalletType = "_walletTypesIdx"; // current wallet type

  Future<void> init() async {
    _storage = GetStorage(_walletKey);
    if (_storage.read(_walletTypes) == null) {
      final types = await loadWalletTypes();

      LogUtil.debug(types);

      setWalletTypes(types);
    }

    if (_storage.read(_walletTypesList) == null) {
      setWalletTypesList(defaultChains);
    }

    if (_storage.read(_currentWalletType) == null) {
      setCurrentWalletType(defaultChains[0]);
    }
  }

  void setWalletTypes(List<WalletType> walleTypes) {
    _storage.write(_walletTypes, walleTypes);
  }

  List<WalletType> getWalletTypes() {
    // return _storage.read(_walletTypes) ?? [];
    final List<dynamic> list = _storage.read(_walletTypes) ?? [];

    LogUtil.debug(list);
    return list.map((item) => WalletType.fromJson(item)).toList();
    // return _storage.read(_walletTypes) ?? [];
  }

  void setWalletTypesList(List<String> walleTypes) {
    _storage.write(_walletTypesList, walleTypes);
  }

  List<String> getWalletTypesList() {
    return _storage.read(_walletTypesList) ?? [];
  }

  void setCurrentWalletType(String walletType) {
    _storage.write(_currentWalletType, walletType);
  }

  String getCurrentWalletType() {
    return _storage.read(_currentWalletType) ?? "";
  }
}
