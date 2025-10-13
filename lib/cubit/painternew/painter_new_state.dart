part of 'painter_new_cubit.dart';

abstract class PainterNewState
    implements Built<PainterNewState, PainterNewStateBuilder> {
  PainterNewState._();

  bool get isLoading;
  String? get error;

  factory PainterNewState([Function(PainterNewStateBuilder b) updates]) =
      _$PainterNewState;

  factory PainterNewState.initial() {
    return PainterNewState((s) => s..isLoading = false);
  }
}
