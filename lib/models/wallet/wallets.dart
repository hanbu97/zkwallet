import 'wallet_types.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallets.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class TokenInfo {
  @HiveField(0)
  String name;
  @HiveField(1)
  String address;
  @HiveField(2)
  String symbol;
  @HiveField(3)
  int decimals;
  @HiveField(4)
  String hint;
  @HiveField(5)
  Map<String, dynamic> extraFields;

  TokenInfo({
    required this.name,
    required this.address,
    this.hint = "",
    this.extraFields = const {},
    this.symbol = "",
    this.decimals = 18,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TokenInfoToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 3)
class WalletRead {
  // without secret info
  @HiveField(0)
  String name;
  @HiveField(1)
  String? address;
  @HiveField(2)
  WalletType walletType;
  @HiveField(3)
  List<String> tokens;

  WalletRead(
      {required this.name,
      required this.address,
      required this.walletType,
      this.tokens = const []});

  factory WalletRead.fromJson(Map<String, dynamic> json) =>
      _$WalletReadFromJson(json);
  Map<String, dynamic> toJson() => _$WalletReadToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 1)
class Wallet extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  String secretKey;

  @HiveField(3)
  String mnemonics;

  // 0: mnemonic + password to secret key
  // 1: save mnemonic to secret key directly
  // 2: sign: private + mnemonic, cold
  // 3: sign: private, cold
  // 4: sign: watch
  // 5: sign: mnemonic + private
  // 6: sign: private
  @HiveField(4)
  int walletMode;

  @HiveField(5)
  List<String> params;

  @HiveField(6)
  Map<String, dynamic> extraFields;

  Wallet({
    required this.name,
    required this.address,
    required this.secretKey,
    required this.mnemonics,
    required this.walletMode,
    this.params = const [],
    this.extraFields = const {},
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
