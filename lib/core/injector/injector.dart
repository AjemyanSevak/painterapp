import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:painter_app/firebase/auth/auth_repository.dart';
import 'package:painter_app/firebase/image/image_repository.dart';

final sl = GetIt.instance;

void call() {
  // Firebase singletons
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(auth: sl()));
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepository(firestore: sl(), storage: sl(), auth: sl()),
  );
}
