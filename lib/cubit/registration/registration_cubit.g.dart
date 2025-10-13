// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_cubit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegistrationState extends RegistrationState {
  @override
  final RegistrationForm registrationForm;
  @override
  final bool isLoading;

  factory _$RegistrationState(
          [void Function(RegistrationStateBuilder)? updates]) =>
      (new RegistrationStateBuilder()..update(updates))._build();

  _$RegistrationState._(
      {required this.registrationForm, required this.isLoading})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        registrationForm, r'RegistrationState', 'registrationForm');
    BuiltValueNullFieldError.checkNotNull(
        isLoading, r'RegistrationState', 'isLoading');
  }

  @override
  RegistrationState rebuild(void Function(RegistrationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegistrationStateBuilder toBuilder() =>
      new RegistrationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegistrationState &&
        registrationForm == other.registrationForm &&
        isLoading == other.isLoading;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, registrationForm.hashCode);
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegistrationState')
          ..add('registrationForm', registrationForm)
          ..add('isLoading', isLoading))
        .toString();
  }
}

class RegistrationStateBuilder
    implements Builder<RegistrationState, RegistrationStateBuilder> {
  _$RegistrationState? _$v;

  RegistrationForm? _registrationForm;
  RegistrationForm? get registrationForm => _$this._registrationForm;
  set registrationForm(RegistrationForm? registrationForm) =>
      _$this._registrationForm = registrationForm;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  RegistrationStateBuilder();

  RegistrationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _registrationForm = $v.registrationForm;
      _isLoading = $v.isLoading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegistrationState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegistrationState;
  }

  @override
  void update(void Function(RegistrationStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegistrationState build() => _build();

  _$RegistrationState _build() {
    final _$result = _$v ??
        new _$RegistrationState._(
            registrationForm: BuiltValueNullFieldError.checkNotNull(
                registrationForm, r'RegistrationState', 'registrationForm'),
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, r'RegistrationState', 'isLoading'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
