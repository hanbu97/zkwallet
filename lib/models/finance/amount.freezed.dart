// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amount.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Amount {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AmountCopyWith<Amount> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountCopyWith<$Res> {
  factory $AmountCopyWith(Amount value, $Res Function(Amount) then) =
      _$AmountCopyWithImpl<$Res, Amount>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$AmountCopyWithImpl<$Res, $Val extends Amount>
    implements $AmountCopyWith<$Res> {
  _$AmountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FiatAmountCopyWith<$Res> implements $AmountCopyWith<$Res> {
  factory _$$FiatAmountCopyWith(
          _$FiatAmount value, $Res Function(_$FiatAmount) then) =
      __$$FiatAmountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, FiatCurrency fiatCurrency});
}

/// @nodoc
class __$$FiatAmountCopyWithImpl<$Res>
    extends _$AmountCopyWithImpl<$Res, _$FiatAmount>
    implements _$$FiatAmountCopyWith<$Res> {
  __$$FiatAmountCopyWithImpl(
      _$FiatAmount _value, $Res Function(_$FiatAmount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? fiatCurrency = freezed,
  }) {
    return _then(_$FiatAmount(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      fiatCurrency: freezed == fiatCurrency
          ? _value.fiatCurrency
          : fiatCurrency // ignore: cast_nullable_to_non_nullable
              as FiatCurrency,
    ));
  }
}

/// @nodoc

class _$FiatAmount extends FiatAmount {
  const _$FiatAmount({required this.value, required this.fiatCurrency})
      : super._();

  @override
  final int value;
  @override
  final FiatCurrency fiatCurrency;

  @override
  String toString() {
    return 'Amount.fiat(value: $value, fiatCurrency: $fiatCurrency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatAmount &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other.fiatCurrency, fiatCurrency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(fiatCurrency));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FiatAmountCopyWith<_$FiatAmount> get copyWith =>
      __$$FiatAmountCopyWithImpl<_$FiatAmount>(this, _$identity);
}

abstract class FiatAmount extends Amount {
  const factory FiatAmount(
      {required final int value,
      required final FiatCurrency fiatCurrency}) = _$FiatAmount;
  const FiatAmount._() : super._();

  @override
  int get value;
  FiatCurrency get fiatCurrency;
  @override
  @JsonKey(ignore: true)
  _$$FiatAmountCopyWith<_$FiatAmount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CryptoAmountCopyWith<$Res> implements $AmountCopyWith<$Res> {
  factory _$$CryptoAmountCopyWith(
          _$CryptoAmount value, $Res Function(_$CryptoAmount) then) =
      __$$CryptoAmountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, CryptoCurrency cryptoCurrency});
}

/// @nodoc
class __$$CryptoAmountCopyWithImpl<$Res>
    extends _$AmountCopyWithImpl<$Res, _$CryptoAmount>
    implements _$$CryptoAmountCopyWith<$Res> {
  __$$CryptoAmountCopyWithImpl(
      _$CryptoAmount _value, $Res Function(_$CryptoAmount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? cryptoCurrency = freezed,
  }) {
    return _then(_$CryptoAmount(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      cryptoCurrency: freezed == cryptoCurrency
          ? _value.cryptoCurrency
          : cryptoCurrency // ignore: cast_nullable_to_non_nullable
              as CryptoCurrency,
    ));
  }
}

/// @nodoc

class _$CryptoAmount extends CryptoAmount {
  const _$CryptoAmount({required this.value, required this.cryptoCurrency})
      : super._();

  @override
  final int value;
  @override
  final CryptoCurrency cryptoCurrency;

  @override
  String toString() {
    return 'Amount.crypto(value: $value, cryptoCurrency: $cryptoCurrency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoAmount &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality()
                .equals(other.cryptoCurrency, cryptoCurrency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(cryptoCurrency));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoAmountCopyWith<_$CryptoAmount> get copyWith =>
      __$$CryptoAmountCopyWithImpl<_$CryptoAmount>(this, _$identity);
}

abstract class CryptoAmount extends Amount {
  const factory CryptoAmount(
      {required final int value,
      required final CryptoCurrency cryptoCurrency}) = _$CryptoAmount;
  const CryptoAmount._() : super._();

  @override
  int get value;
  CryptoCurrency get cryptoCurrency;
  @override
  @JsonKey(ignore: true)
  _$$CryptoAmountCopyWith<_$CryptoAmount> get copyWith =>
      throw _privateConstructorUsedError;
}
