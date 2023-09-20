import '../../models/wallet/wallets.dart';
import '../../models/wallet/wallets_group.dart';
import 'secure_storeage.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

const dbName = "keyBoxEncrypted";
List<int> dbKey = [];

enum HiveDBName { walletGroup, walletType, generalConfig }

String hiveDBNameToString(HiveDBName dbName) {
  switch (dbName) {
    case HiveDBName.walletGroup:
      return 'falafi_wallet_group1';
    case HiveDBName.walletType:
      return 'falafi_wallet_type1';
    case HiveDBName.generalConfig:
      return 'falafi_general_config1';
    default:
      throw Exception('Invalid HiveDBName value');
  }
}

// clear db
void dbClearSafe(HiveDBName db) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  encryptedBox.clear();
}

Future<void> dbClear(HiveDBName db) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  encryptedBox.clear();

  return;
}

Future<void> initKey() async {
  if (dbKey.isEmpty) {
    final StorageService storageService = StorageService();

    final storedKey = await storageService.readSecureData("wallet_hivedb_key");

    if (storedKey != null) {
      dbKey = base64Url.decode(storedKey);
    } else {
      dbKey = Hive.generateSecureKey();
      final encodedKey = base64UrlEncode(dbKey);
      // print(encodedKey);
      final StorageItem newItem = StorageItem("wallet_hivedb_key", encodedKey);
      storageService.writeSecureData(newItem);
    }
  }
}

void dbAddSafe(HiveDBName db, dynamic value) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  encryptedBox.add(value);
  return;
}

Future<void> dbAdd(HiveDBName db, dynamic value) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  encryptedBox.add(value);
  return;
}

Future<bool> dbExistName(HiveDBName db, String name) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  final filtered = encryptedBox.values.where((item) => item.name == (name));
  if (filtered.isNotEmpty) {
    return true;
  }
  return false;
}

Future<dynamic> dbEntity(HiveDBName db) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));

  return encryptedBox;
}

Future<dynamic> dbEntityString(String db) async {
  await initKey();
  final encryptedBox =
      await Hive.openBox(db, encryptionCipher: HiveAesCipher(dbKey));

  return encryptedBox;
}

Future<dynamic> dbGetAll(HiveDBName db) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));

  return encryptedBox.values.toList();
}

Future<WalletGroup> dbGetGroup(HiveDBName db, String groupName) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  final group = encryptedBox.values.where((item) => item.name == (groupName));
  var wallet = group.first;

  wallet = wallet is WalletGroup ? wallet : WalletGroup.fromJson(wallet);

  return wallet;
}

Future<Wallet> dbGetGroupWallet(HiveDBName db, String groupName) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  final group = encryptedBox.values.where((item) => item.name == (groupName));
  var wallet = group.first;

  wallet = wallet is WalletGroup ? wallet : WalletGroup.fromJson(wallet);
  wallet = wallet.wallets.first;

  return wallet;
}

Future<void> dbInsert(dynamic key, dynamic value) async {
  await initKey();
  final encryptedBox =
      await Hive.openBox(dbName, encryptionCipher: HiveAesCipher(dbKey));
  encryptedBox.put(key, value);
  return;
}

// delete db item where name equals
Future<void> dbDelete(HiveDBName db, String name) async {
  await initKey();
  final encryptedBox = await Hive.openBox(hiveDBNameToString(db),
      encryptionCipher: HiveAesCipher(dbKey));
  final filtered = encryptedBox.values.where((item) => item.name == (name));
  if (filtered.isNotEmpty) {
    encryptedBox.delete(filtered.first.key);
  }
  return;
}
