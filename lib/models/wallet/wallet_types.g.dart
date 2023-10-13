// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletTypeAdapter extends TypeAdapter<WalletType> {
  @override
  final int typeId = 0;

  @override
  WalletType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletType(
      id: fields[0] as String,
      family: fields[1] as String,
      name: fields[2] as String,
      symbol: fields[3] as String,
      chainId: fields[4] as int,
      ss58: fields[5] as int,
      decimal: fields[6] as int,
      hash: fields[7] as String,
      rpc: (fields[8] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      rpcSelect: fields[9] as int,
      wss: (fields[10] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      wssSelect: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WalletType obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.family)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.chainId)
      ..writeByte(5)
      ..write(obj.ss58)
      ..writeByte(6)
      ..write(obj.decimal)
      ..writeByte(7)
      ..write(obj.hash)
      ..writeByte(8)
      ..write(obj.rpc)
      ..writeByte(9)
      ..write(obj.rpcSelect)
      ..writeByte(10)
      ..write(obj.wss)
      ..writeByte(11)
      ..write(obj.wssSelect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletType _$WalletTypeFromJson(Map<String, dynamic> json) => WalletType(
      id: json['id'] as String,
      family: json['family'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      chainId: json['chainId'] as int? ?? 0,
      ss58: json['ss58'] as int? ?? 0,
      decimal: json['decimal'] as int,
      hash: json['hash'] as String,
      rpc: (json['rpc'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      rpcSelect: json['rpcSelect'] as int? ?? 0,
      wss: (json['wss'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      wssSelect: json['wssSelect'] as int? ?? 0,
    );

Map<String, dynamic> _$WalletTypeToJson(WalletType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'family': instance.family,
      'name': instance.name,
      'symbol': instance.symbol,
      'chainId': instance.chainId,
      'ss58': instance.ss58,
      'decimal': instance.decimal,
      'hash': instance.hash,
      'rpc': instance.rpc,
      'rpcSelect': instance.rpcSelect,
      'wss': instance.wss,
      'wssSelect': instance.wssSelect,
    };
