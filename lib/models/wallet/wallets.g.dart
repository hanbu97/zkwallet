// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallets.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenInfoAdapter extends TypeAdapter<TokenInfo> {
  @override
  final int typeId = 5;

  @override
  TokenInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenInfo(
      name: fields[0] as String,
      address: fields[1] as String,
      hint: fields[4] as String,
      extraFields: (fields[5] as Map).cast<String, dynamic>(),
      symbol: fields[2] as String,
      decimals: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TokenInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.decimals)
      ..writeByte(4)
      ..write(obj.hint)
      ..writeByte(5)
      ..write(obj.extraFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletReadAdapter extends TypeAdapter<WalletRead> {
  @override
  final int typeId = 3;

  @override
  WalletRead read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletRead(
      name: fields[0] as String,
      address: fields[1] as String?,
      walletType: fields[2] as WalletType,
      tokens: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, WalletRead obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.walletType)
      ..writeByte(3)
      ..write(obj.tokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletReadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletAdapter extends TypeAdapter<Wallet> {
  @override
  final int typeId = 1;

  @override
  Wallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wallet(
      name: fields[0] as String,
      address: fields[1] as String,
      secretKey: fields[2] as String,
      mnemonics: fields[3] as String,
      walletMode: fields[4] as int,
      params: (fields[5] as List).cast<String>(),
      extraFields: (fields[6] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Wallet obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.secretKey)
      ..writeByte(3)
      ..write(obj.mnemonics)
      ..writeByte(4)
      ..write(obj.walletMode)
      ..writeByte(5)
      ..write(obj.params)
      ..writeByte(6)
      ..write(obj.extraFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenInfo _$TokenInfoFromJson(Map<String, dynamic> json) => TokenInfo(
      name: json['name'] as String,
      address: json['address'] as String,
      hint: json['hint'] as String? ?? "",
      extraFields: json['extraFields'] as Map<String, dynamic>? ?? const {},
      symbol: json['symbol'] as String? ?? "",
      decimals: json['decimals'] as int? ?? 18,
    );

Map<String, dynamic> _$TokenInfoToJson(TokenInfo instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'hint': instance.hint,
      'extraFields': instance.extraFields,
    };

WalletRead _$WalletReadFromJson(Map<String, dynamic> json) => WalletRead(
      name: json['name'] as String,
      address: json['address'] as String?,
      walletType:
          WalletType.fromJson(json['walletType'] as Map<String, dynamic>),
      tokens: (json['tokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WalletReadToJson(WalletRead instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'walletType': instance.walletType,
      'tokens': instance.tokens,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      name: json['name'] as String,
      address: json['address'] as String,
      secretKey: json['secretKey'] as String,
      mnemonics: json['mnemonics'] as String,
      walletMode: json['walletMode'] as int,
      params: (json['params'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      extraFields: json['extraFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'secretKey': instance.secretKey,
      'mnemonics': instance.mnemonics,
      'walletMode': instance.walletMode,
      'params': instance.params,
      'extraFields': instance.extraFields,
    };
