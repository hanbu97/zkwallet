// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallets_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletGroupAdapter extends TypeAdapter<WalletGroup> {
  @override
  final int typeId = 2;

  @override
  WalletGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletGroup(
      idx: fields[0] as int,
      name: fields[1] as String,
      wallets: (fields[2] as List).cast<Wallet>(),
      walletTypes: (fields[3] as List).cast<WalletType>(),
      mnemonics: (fields[5] as List).cast<String>(),
      contact: (fields[7] as List).cast<ContactInfo>(),
      walletGroupMode: (fields[6] as List).cast<int>(),
      params: (fields[8] as List)
          .map((dynamic e) => (e as List).cast<String>())
          .toList(),
      extraFields: (fields[9] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, WalletGroup obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idx)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.wallets)
      ..writeByte(3)
      ..write(obj.walletTypes)
      ..writeByte(5)
      ..write(obj.mnemonics)
      ..writeByte(6)
      ..write(obj.walletGroupMode)
      ..writeByte(7)
      ..write(obj.contact)
      ..writeByte(8)
      ..write(obj.params)
      ..writeByte(9)
      ..write(obj.extraFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

WalletGroup _$WalletGroupFromJson(Map<String, dynamic> json) => WalletGroup(
      idx: json['idx'] as int,
      name: json['name'] as String,
      wallets: (json['wallets'] as List<dynamic>?)
              ?.map((e) => Wallet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      walletTypes: (json['walletTypes'] as List<dynamic>?)
              ?.map((e) => WalletType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mnemonics:
          (json['mnemonics'] as List<dynamic>).map((e) => e as String).toList(),
      contact: (json['contact'] as List<dynamic>?)
              ?.map((e) => ContactInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      walletGroupMode: (json['walletGroupMode'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      params: (json['params'] as List<dynamic>?)
              ?.map(
                  (e) => (e as List<dynamic>).map((e) => e as String).toList())
              .toList() ??
          const [],
      extraFields: json['extraFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$WalletGroupToJson(WalletGroup instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'wallets': instance.wallets,
      'walletTypes': instance.walletTypes,
      'mnemonics': instance.mnemonics,
      'walletGroupMode': instance.walletGroupMode,
      'contact': instance.contact,
      'params': instance.params,
      'extraFields': instance.extraFields,
    };
