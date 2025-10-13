// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter_new_cubit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PainterNewState extends PainterNewState {
  @override
  final bool isLoading;
  @override
  final String? error;

  factory _$PainterNewState([void Function(PainterNewStateBuilder)? updates]) =>
      (new PainterNewStateBuilder()..update(updates))._build();

  _$PainterNewState._({required this.isLoading, this.error}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isLoading, r'PainterNewState', 'isLoading');
  }

  @override
  PainterNewState rebuild(void Function(PainterNewStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PainterNewStateBuilder toBuilder() =>
      new PainterNewStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PainterNewState &&
        isLoading == other.isLoading &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isLoading.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PainterNewState')
          ..add('isLoading', isLoading)
          ..add('error', error))
        .toString();
  }
}

class PainterNewStateBuilder
    implements Builder<PainterNewState, PainterNewStateBuilder> {
  _$PainterNewState? _$v;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  PainterNewStateBuilder();

  PainterNewStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLoading = $v.isLoading;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PainterNewState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PainterNewState;
  }

  @override
  void update(void Function(PainterNewStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PainterNewState build() => _build();

  _$PainterNewState _build() {
    final _$result = _$v ??
        new _$PainterNewState._(
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, r'PainterNewState', 'isLoading'),
            error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
