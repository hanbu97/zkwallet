import 'dart:convert';

import 'package:waterspay/chains/config.dart';
import 'package:waterspay/utils/log/logger.dart';

import 'wallets.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_types.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class WalletType extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String family;

  @HiveField(2)
  String name;

  @HiveField(3)
  String symbol;

  @HiveField(4)
  int chainId;

  @HiveField(5)
  int ss58;

  @HiveField(6)
  int decimal;

  @HiveField(7)
  String hash;

  @HiveField(8)
  List<Map<String, dynamic>> rpc;

  @HiveField(9)
  int rpcSelect;

  @HiveField(10)
  List<Map<String, dynamic>> wss;

  @HiveField(11)
  int wssSelect;

  WalletType({
    required this.id,
    required this.family,
    required this.name,
    required this.symbol,
    this.chainId = 0,
    this.ss58 = 0,
    required this.decimal,
    required this.hash,
    required this.rpc,
    this.rpcSelect = 0,
    required this.wss,
    this.wssSelect = 0,
  });

  factory WalletType.fromJson(Map<String, dynamic> json) =>
      _$WalletTypeFromJson(json);
  Map<String, dynamic> toJson() => _$WalletTypeToJson(this);
}

Future<List<WalletType>> loadWalletTypes() async {
  final List<WalletType> walletTypes = [];

  for (final chain in chainsConfig.keys) {
    // for (final chain in defaultChains) {
    final chainJson = Map<String, dynamic>.from(chainsConfig[chain]);
    final walletType = WalletType.fromJson(chainJson);
    walletTypes.add(walletType);
  }

  return walletTypes;
}
