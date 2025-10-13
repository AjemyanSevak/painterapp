import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:painter_app/firebase/image/image_repository.dart';
import 'package:painter_app/main.dart';

part 'painter_edit_cubit.g.dart';
part 'painter_edit_state.dart';

class PainterEditCubit extends Cubit<PainterEditState> {
  PainterEditCubit({ImageRepository? repo}) : super(PainterEditState.initial());

  /// - Optionally delete old object
  Future<void> replaceWithNewVersion({
    required String docId,
    required String oldStoragePath,
    required Uint8List newBytes,
    String? newTitle,
    int? width,
    int? height,
    bool deleteOld = true,
  }) async {
    emit(
      state.rebuild(
        (s) => s
          ..error = null
          ..isLoading = true,
      ),
    );

    try {
      final firestore = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;
      final storage = FirebaseStorage.instance;

      final ext = '.png';
      final revName = 'img_${DateTime.now().millisecondsSinceEpoch}_rev$ext';
      final newStoragePath = 'users/${auth.currentUser!.uid}/images/$revName';

      final newRef = storage.ref(newStoragePath);
      await newRef.putData(
        newBytes,
        SettableMetadata(contentType: 'image/png'),
      );
      final newUrl = await newRef.getDownloadURL();

      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('images')
          .doc(docId)
          .update({
            'url': newUrl,
            'storagePath': newStoragePath,
            'title': (newTitle?.trim().isEmpty ?? true) ? null : newTitle,
            'sizeBytes': newBytes.length,
            'width': width,
            'height': height,
            'updatedAt': FieldValue.serverTimestamp(),
          });

      if (deleteOld) {
        await storage.ref(oldStoragePath).delete();
      }

      await showNotification(
        'Image updated successfully',
        'The image has been replaced with the new version.',
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
}
