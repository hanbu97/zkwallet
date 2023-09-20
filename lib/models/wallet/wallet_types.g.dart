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
      name: fields[0] as String,
      family: fields[1] as String,
      network: (fields[2] as List)
          .map((dynamic e) => (e as List).cast<String>())
          .toList(),
      networkId: (fields[3] as List).cast<String>(),
      authority: (fields[5] as List).cast<String>(),
      networkIdName: (fields[4] as List).cast<String>(),
      tokens: (fields[6] as List).cast<TokenInfo>(),
      explorer: (fields[7] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
      derive: (fields[8] as List).cast<String>(),
      extraFields: (fields[9] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, WalletType obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.family)
      ..writeByte(2)
      ..write(obj.network)
      ..writeByte(3)
      ..write(obj.networkId)
      ..writeByte(4)
      ..write(obj.networkIdName)
      ..writeByte(5)
      ..write(obj.authority)
      ..writeByte(6)
      ..write(obj.tokens)
      ..writeByte(7)
      ..write(obj.explorer)
      ..writeByte(8)
      ..write(obj.derive)
      ..writeByte(9)
      ..write(obj.extraFields);
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
      name: json['name'] as String,
      family: json['family'] as String? ?? "",
      network: (json['network'] as List<dynamic>?)
              ?.map(
                  (e) => (e as List<dynamic>).map((e) => e as String).toList())
              .toList() ??
          const [],
      networkId: (json['networkId'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      authority: (json['authority'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      networkIdName: (json['networkIdName'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tokens: (json['tokens'] as List<dynamic>?)
              ?.map((e) => TokenInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      explorer: (json['explorer'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          const [],
      derive: (json['derive'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      extraFields: json['extraFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$WalletTypeToJson(WalletType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'family': instance.family,
      'network': instance.network,
      'networkId': instance.networkId,
      'networkIdName': instance.networkIdName,
      'authority': instance.authority,
      'tokens': instance.tokens,
      'explorer': instance.explorer,
      'derive': instance.derive,
      'extraFields': instance.extraFields,
    };
