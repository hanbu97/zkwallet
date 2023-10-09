// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Currency {}

/// @nodoc

class _$FiatCurrency extends FiatCurrency {
  const _$FiatCurrency(
      {required this.name,
      required this.decimals,
      required this.symbol,
      required this.sign})
      : super._();

  @override
  final String name;
  @override
  final int decimals;
  @override
  final String symbol;
  @override
  final String sign;

  @override
  String toString() {
    return 'Currency.fiat(name: $name, decimals: $decimals, symbol: $symbol, sign: $sign)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatCurrency &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.sign, sign) || other.sign == sign));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, decimals, symbol, sign);
}

abstract class FiatCurrency extends Currency {
  const factory FiatCurrency(
      {required final String name,
      required final int decimals,
      required final String symbol,
      required final String sign}) = _$FiatCurrency;
  const FiatCurrency._() : super._();

  String get name;
  int get decimals;
  String get symbol;
  String get sign;
}

/// @nodoc

class _$CryptoCurrency extends CryptoCurrency {
  const _$CryptoCurrency({required this.token}) : super._();

  @override
  final Token token;

  @override
  String toString() {
    return 'Currency.crypto(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoCurrency &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);
}

abstract class CryptoCurrency extends Currency {
  const factory CryptoCurrency({required final Token token}) = _$CryptoCurrency;
  const CryptoCurrency._() : super._();

  Token get token;
}
