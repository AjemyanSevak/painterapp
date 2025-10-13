// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter_edit_cubit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PainterEditState extends PainterEditState {
  @override
  final bool isLoading;
  @override
  final String? error;

  factory _$PainterEditState(
          [void Function(PainterEditStateBuilder)? updates]) =>
      (new PainterEditStateBuilder()..update(updates))._build();

  _$PainterEditState._({required this.isLoading, this.error}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isLoading, r'PainterEditState', 'isLoading');
  }

  @override
  PainterEditState rebuild(void Function(PainterEditStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PainterEditStateBuilder toBuilder() =>
      new PainterEditStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PainterEditState &&
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
    return (newBuiltValueToStringHelper(r'PainterEditState')
          ..add('isLoading', isLoading)
          ..add('error', error))
        .toString();
  }
}

class PainterEditStateBuilder
    implements Builder<PainterEditState, PainterEditStateBuilder> {
  _$PainterEditState? _$v;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  PainterEditStateBuilder();

  PainterEditStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLoading = $v.isLoading;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PainterEditState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PainterEditState;
  }

  @override
  void update(void Function(PainterEditStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PainterEditState build() => _build();

  _$PainterEditState _build() {
    final _$result = _$v ??
        new _$PainterEditState._(
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, r'PainterEditState', 'isLoading'),
            error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
