part of 'painter_edit_cubit.dart';

abstract class PainterEditState
    implements Built<PainterEditState, PainterEditStateBuilder> {
  PainterEditState._();

  bool get isLoading;
  String? get error;

  factory PainterEditState([Function(PainterEditStateBuilder b) updates]) =
      _$PainterEditState;

  factory PainterEditState.initial() {
    return PainterEditState((s) => s..isLoading = false);
  }
}
