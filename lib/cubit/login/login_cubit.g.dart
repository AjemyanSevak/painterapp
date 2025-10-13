// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_cubit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginState extends LoginState {
  @override
  final LoginForm loginForm;
  @override
  final bool isLoading;

  factory _$LoginState([void Function(LoginStateBuilder)? updates]) =>
      (new LoginStateBuilder()..update(updates))._build();

  _$LoginState._({required this.loginForm, required this.isLoading})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        loginForm, r'LoginState', 'loginForm');
    BuiltValueNullFieldError.checkNotNull(
        isLoading, r'LoginState', 'isLoading');
  }

  @override
  LoginState rebuild(void Function(LoginStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginStateBuilder toBuilder() => new LoginStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginState &&
        loginForm == other.loginForm &&
        isLoading == other.isLoading;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, loginForm.hashCode);
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginState')
          ..add('loginForm', loginForm)
          ..add('isLoading', isLoading))
        .toString();
  }
}

class LoginStateBuilder implements Builder<LoginState, LoginStateBuilder> {
  _$LoginState? _$v;

  LoginForm? _loginForm;
  LoginForm? get loginForm => _$this._loginForm;
  set loginForm(LoginForm? loginForm) => _$this._loginForm = loginForm;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  LoginStateBuilder();

  LoginStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loginForm = $v.loginForm;
      _isLoading = $v.isLoading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginState;
  }

  @override
  void update(void Function(LoginStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginState build() => _build();

  _$LoginState _build() {
    final _$result = _$v ??
        new _$LoginState._(
            loginForm: BuiltValueNullFieldError.checkNotNull(
                loginForm, r'LoginState', 'loginForm'),
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, r'LoginState', 'isLoading'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
