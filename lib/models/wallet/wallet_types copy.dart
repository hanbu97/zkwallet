// import 'dart:convert';

// import 'wallets.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'wallet_types.g.dart';

// @JsonSerializable()
// @HiveType(typeId: 0)
// class WalletType extends HiveObject {
//   @HiveField(0)
//   String name;

//   @HiveField(1)
//   String family;

//   // rpc
//   @HiveField(2)
//   List<List<String>> network;

//   @HiveField(3)
//   List<String> networkId;

//   @HiveField(4)
//   List<String> networkIdName;

//   @HiveField(5)
//   List<String> authority;

//   @HiveField(6)
//   List<TokenInfo> tokens;

//   @HiveField(7)
//   List<Map<String, String>> explorer;

//   @HiveField(8)
//   List<String> derive;

//   @HiveField(9)
//   Map<String, dynamic> extraFields;

//   WalletType({
//     required this.name,
//     this.family = "",
//     this.network = const [],
//     this.networkId = const [],
//     this.authority = const [],
//     this.networkIdName = const [],
//     this.tokens = const [],
//     this.explorer = const [],
//     this.derive = const [],
//     this.extraFields = const {},
//   });

//   factory WalletType.fromJson(Map<String, dynamic> json) =>
//       _$WalletTypeFromJson(json);
//   Map<String, dynamic> toJson() => _$WalletTypeToJson(this);
// }

// WalletType walletTypeFromJson(String jsonStr) {
//   final parsedJson = json.decode(jsonStr);
//   return WalletType(
//     name: parsedJson['name'],
//     family: parsedJson['family'],
//     network: List<List<String>>.from(
//         parsedJson['network'].map((x) => List<String>.from(x.map((y) => y)))),
//     networkId: List<String>.from(parsedJson['networkId'].map((x) => x)),
//     networkIdName: List<String>.from(parsedJson['networkIdName'].map((x) => x)),
//     authority: List<String>.from(parsedJson['authority'].map((x) => x)),
//     tokens: List<TokenInfo>.from(
//         parsedJson['tokens'].map((x) => TokenInfo.fromJson(x))),
//     explorer: List<Map<String, String>>.from(
//         parsedJson['explorer'].map((x) => Map<String, String>.from(x))),
//     derive: List<String>.from(parsedJson['derive'].map((x) => x)),
//     extraFields: Map<String, dynamic>.from(parsedJson['extraFields']),
//   );
// }

// Future<List<WalletType>> loadWalletTypes() async {
//   final manifest = await rootBundle.loadString('AssetManifest.json');
//   final fileNames = Map<String, dynamic>.from(json.decode(manifest))
//       .keys
//       .where((String key) => key.startsWith('assets/wallet_types/'))
//       .toList();

//   final List<WalletType> walletTypes = [];

//   for (final fileName in fileNames) {
//     final jsonStr = await rootBundle.loadString(fileName);
//     final walletType = walletTypeFromJson(jsonStr);
//     walletTypes.add(walletType);
//   }

//   return walletTypes;
// }
