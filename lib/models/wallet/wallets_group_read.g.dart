// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallets_group_read.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletGroupReadAdapter extends TypeAdapter<WalletGroupRead> {
  @override
  final int typeId = 4;

  @override
  WalletGroupRead read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletGroupRead(
      idx: fields[0] as int,
      name: fields[1] as String,
      wallets: (fields[2] as List).cast<WalletRead>(),
      contact: (fields[3] as List).cast<ContactInfo>(),
      networks: (fields[4] as List?)?.cast<String>(),
      tokens: (fields[5] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, WalletGroupRead obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idx)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.wallets)
      ..writeByte(3)
      ..write(obj.contact)
      ..writeByte(4)
      ..write(obj.networks)
      ..writeByte(5)
      ..write(obj.tokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletGroupReadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletGroupRead _$WalletGroupReadFromJson(Map<String, dynamic> json) =>
    WalletGroupRead(
      idx: json['idx'] as int,
      name: json['name'] as String,
      wallets: (json['wallets'] as List<dynamic>)
          .map((e) => WalletRead.fromJson(e as Map<String, dynamic>))
          .toList(),
      contact: (json['contact'] as List<dynamic>?)
              ?.map((e) => ContactInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      networks: (json['networks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tokens: (json['tokens'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          const {},
    );

Map<String, dynamic> _$WalletGroupReadToJson(WalletGroupRead instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'wallets': instance.wallets,
      'contact': instance.contact,
      'networks': instance.networks,
      'tokens': instance.tokens,
    };

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) => ContactInfo(
      name: json['name'] as String,
      address: json['address'] as String,
      hint: json['hint'] as String? ?? "",
      extraFields: json['extraFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'hint': instance.hint,
      'extraFields': instance.extraFields,
    };
