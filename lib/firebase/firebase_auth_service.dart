// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zazen/github/github_service.dart';

final authStateProvider = StreamProvider<User?>((_) {
  return FirebaseAuth.instance.authStateChanges();
});

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>(
  (ref) => FirebaseAuthService(
    ref.watch(githubServiceProvider),
  ),
);

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GithubService _githubService;

  FirebaseAuthService(this._githubService);

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result;
  }

  Future<void> get signOut async => await _firebaseAuth.signOut();

  Stream<User?> get authStateStream => _firebaseAuth.authStateChanges();

  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  Future<UserCredential?> signInWithGithub(BuildContext context) async {
    final result = await _githubService.signIn(context);

    final token = result.token;
    if (token == null) {
      return null;
    }

    final AuthCredential githubAuthCredential =
        GithubAuthProvider.credential(result.token!);

    return await _firebaseAuth.signInWithCredential(githubAuthCredential);
  }
}
