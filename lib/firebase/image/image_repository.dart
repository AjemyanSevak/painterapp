import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:painter_app/models/image/image_model.dart';

class ImageRepository {
  ImageRepository({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _storage = storage,
       _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  String get _uid => _auth.currentUser!.uid;

  /// Uploads bytes (or file) to Storage and writes metadata under users/{uid}/images.
  /// Returns the Firestore doc ID.
  Future<String> uploadImage({
    required Uint8List bytes,
    String? fileName, // optional (fallback to timestamp)
    String? title, // optional user title
    int? width,
    int? height,
  }) async {
    final name = fileName ?? 'img_${DateTime.now().millisecondsSinceEpoch}.png';
    final storagePath = 'users/$_uid/images/$name';

    // 1) Upload to Storage
    final task = await _storage
        .ref(storagePath)
        .putData(bytes, SettableMetadata(contentType: 'image/png'));
    final url = await task.ref.getDownloadURL();

    // 2) Save metadata in Firestore subcollection
    final doc = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('images')
        .add({
          'url': url,
          'storagePath': storagePath,
          'title': (title?.trim().isEmpty ?? true) ? null : title,
          'sizeBytes': bytes.length,
          'width': width,
          'height': height,
          'createdAt': FieldValue.serverTimestamp(),
        });

    return doc.id;
  }

  /// If you have a File path instead of bytes.
  Future<String> uploadFile({required File file, String? title}) async {
    final name =
        'img_${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
    final storagePath = 'users/$_uid/images/$name';
    final task = await _storage.ref(storagePath).putFile(file);
    final url = await task.ref.getDownloadURL();

    final doc = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('images')
        .add({
          'url': url,
          'storagePath': storagePath,
          'title': (title?.trim().isEmpty ?? true) ? null : title,
          'sizeBytes': await file.length(),
          'width': null,
          'height': null,
          'createdAt': FieldValue.serverTimestamp(),
        });

    return doc.id;
  }

  /// Live stream of all images for the current user (newest first).
  Stream<List<ImageDoc>> imagesStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('images')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => ImageDoc.fromDoc(d)).toList());
  }

  /// Optional: delete image (Storage + Firestore)
  Future<void> deleteImage(String docId, String storagePath) async {
    await _storage.ref(storagePath).delete();
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('images')
        .doc(docId)
        .delete();
  }
}
