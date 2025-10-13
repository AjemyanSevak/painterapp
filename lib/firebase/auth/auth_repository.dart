// lib/auth/auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) => _auth.signInWithEmailAndPassword(
    email: email.trim(),
    password: password.trim(),
  );

  Future<UserCredential> register({
    required String email,
    required String password,
  }) => _auth.createUserWithEmailAndPassword(
    email: email.trim(),
    password: password.trim(),
  );

  Future<void> signOut() => _auth.signOut();

  User? get currentUser => _auth.currentUser;
}
