import 'wallet_types.dart';
import 'wallets.dart';
import 'wallets_group_read.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallets_group.g.dart';

@JsonSerializable()
class ContactInfo {
  String name;
  String address;
  String hint;
  Map<String, dynamic> extraFields;

  ContactInfo(
      {required this.name,
      required this.address,
      this.hint = "",
      this.extraFields = const {}});

  factory ContactInfo.fromJson(Map<String, dynamic> json) =>
      _$ContactInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 2)
class WalletGroup extends HiveObject {
  @HiveField(0)
  int idx;

  @HiveField(1)
  String name;

  @HiveField(2)
  // relate to wallet db
  List<Wallet> wallets;

  @HiveField(3)
  // relate to wallet type db
  List<WalletType> walletTypes;

  @HiveField(5)
  List<String> mnemonics;

  @HiveField(6)
  List<int> walletGroupMode;

  @HiveField(7)
  List<ContactInfo> contact;

  @HiveField(8)
  List<List<String>> params;

  @HiveField(9)
  Map<String, dynamic> extraFields;

  WalletGroup({
    required this.idx,
    required this.name,
    this.wallets = const [],
    this.walletTypes = const [],
    required this.mnemonics,
    this.contact = const [],
    this.walletGroupMode = const [],
    this.params = const [],
    this.extraFields = const {},
  });

  // to WalletGroupRead
  WalletGroupRead toWalletGroupRead() {
    List<WalletRead> walletReads = [];
    for (var i = 0; i < wallets.length; i++) {
      walletReads.add(
        WalletRead(
            name: wallets[i].name,
            address: wallets[i].address,
            walletType: walletTypes[i]),
      );
    }

    return WalletGroupRead(idx: idx, name: name, wallets: walletReads);
  }

  factory WalletGroup.fromJson(Map<String, dynamic> json) =>
      _$WalletGroupFromJson(json);
  Map<String, dynamic> toJson() => _$WalletGroupToJson(this);
}
