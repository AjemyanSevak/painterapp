// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_cubit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LocaleState extends LocaleState {
  @override
  final Locale locale;

  factory _$LocaleState([void Function(LocaleStateBuilder)? updates]) =>
      (new LocaleStateBuilder()..update(updates))._build();

  _$LocaleState._({required this.locale}) : super._() {
    BuiltValueNullFieldError.checkNotNull(locale, r'LocaleState', 'locale');
  }

  @override
  LocaleState rebuild(void Function(LocaleStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocaleStateBuilder toBuilder() => new LocaleStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocaleState && locale == other.locale;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LocaleState')..add('locale', locale))
        .toString();
  }
}

class LocaleStateBuilder implements Builder<LocaleState, LocaleStateBuilder> {
  _$LocaleState? _$v;

  Locale? _locale;
  Locale? get locale => _$this._locale;
  set locale(Locale? locale) => _$this._locale = locale;

  LocaleStateBuilder();

  LocaleStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _locale = $v.locale;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocaleState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LocaleState;
  }

  @override
  void update(void Function(LocaleStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocaleState build() => _build();

  _$LocaleState _build() {
    final _$result = _$v ??
        new _$LocaleState._(
            locale: BuiltValueNullFieldError.checkNotNull(
                locale, r'LocaleState', 'locale'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
