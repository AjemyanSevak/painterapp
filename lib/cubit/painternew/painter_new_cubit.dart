import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:painter_app/core/injector/injector.dart';
import 'package:painter_app/firebase/image/image_repository.dart';
import 'package:painter_app/main.dart';
import 'package:painter_app/models/image/image_model.dart';

part 'painter_new_cubit.g.dart';
part 'painter_new_state.dart';

class PainterNewCubit extends Cubit<PainterNewState> {
  PainterNewCubit({ImageRepository? repo})
    : _repo = repo ?? sl(),
      super(PainterNewState.initial());

  final ImageRepository _repo;

  Future<void> uploadBytes(
    Uint8List bytes, {
    String? fileName,
    String? title,
    int? w,
    int? h,
  }) async {
    emit(
      state.rebuild(
        (s) => s
          ..error = null
          ..isLoading = true,
      ),
    );

    try {
      await _repo.uploadImage(
        bytes: bytes,
        fileName: fileName,
        title: title,
        width: w,
        height: h,
      );

      await showNotification(
        'Image uploaded successfully',
        'The image has been uploaded.',
      );

      emit(state.rebuild((s) => s.isLoading = false));
    } catch (e) {
      emit(
        state.rebuild(
          (s) => s
            ..error = e.toString()
            ..isLoading = false,
        ),
      );
    }
  }

  Future<void> delete(ImageDoc doc) async {
    emit(
      state.rebuild(
        (s) => s
          ..error = null
          ..isLoading = false,
      ),
    );

    try {
      await _repo.deleteImage(doc.id, doc.storagePath);
      emit(state.rebuild((s) => s.isLoading = false));
    } catch (e) {
      emit(
        state.rebuild(
          (s) => s
            ..error = e.toString()
            ..isLoading = false,
        ),
      );
    }
  }
}
