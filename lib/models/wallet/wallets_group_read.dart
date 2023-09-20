import 'wallet_types.dart';
import 'wallets.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallets_group_read.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class WalletGroupRead {
  // without secret info
  @HiveField(0)
  int idx;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<WalletRead> wallets;
  @HiveField(3)
  List<ContactInfo> contact;
  @HiveField(4)
  List<String>? networks;
  @HiveField(5)
  Map<String, List<String>>? tokens;

  WalletGroupRead(
      {required this.idx,
      required this.name,
      required this.wallets,
      this.contact = const [],
      this.networks = const [],
      this.tokens = const {}});

  factory WalletGroupRead.fromJson(Map<String, dynamic> json) =>
      _$WalletGroupReadFromJson(json);
  Map<String, dynamic> toJson() => _$WalletGroupReadToJson(this);
}

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
