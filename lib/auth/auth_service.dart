// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import '../firebase/firebase_auth_service.dart';

final authServiceProvider = Provider<AuthService>(
    (ref) => AuthService(ref.watch(firebaseAuthServiceProvider)));

final authStateStreamProvider = StreamProvider.autoDispose<User?>((ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return firebaseAuthService.authStateStream;
});

class AuthService {
  AuthService(
    this._firebaseAuthService,
  );
  final FirebaseAuthService _firebaseAuthService;

  User? get currentUser => _firebaseAuthService.currentUser;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      await _firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);

  Future<void> signOut() async => await _firebaseAuthService.signOut;

  Stream<User?> get authStateStream => _firebaseAuthService.authStateStream;

  String? get currentUserId => _firebaseAuthService.currentUserId;
}
