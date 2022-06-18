// 📦 Package imports:
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:zazen/firebase/cloud_firestore/cloud_firestore_service.dart';
import 'package:zazen/firebase/cloud_firestore/firestore_path.dart';

// 🌎 Project imports:
import '../firebase/firebase_auth_service.dart';

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(
    ref.watch(cloudFirestoreServiceProvider),
    ref.watch(firebaseAuthServiceProvider),
  ),
);

final authStateStreamProvider = StreamProvider.autoDispose<User?>((ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return firebaseAuthService.authStateStream;
});

class AuthService {
  AuthService(
    this._cloudFirestoreService,
    this._firebaseAuthService,
  );
  final CloudFirestoreService _cloudFirestoreService;
  final FirebaseAuthService _firebaseAuthService;

  User? get currentUser => _firebaseAuthService.currentUser;

  Future<void> signOut() async => await _firebaseAuthService.signOut;

  Stream<User?> get authStateStream => _firebaseAuthService.authStateStream;

  String? get currentUserId => _firebaseAuthService.currentUserId;

  Future<void> signInWithGithub(BuildContext context) async {
    if (kIsWeb) {
      await _signInWithGithubForWeb();
    } else if (Platform.isAndroid || Platform.isIOS) {
      await _signInWithGithubForNative(context);
    }
  }

  Future<void> _signInWithGithubForWeb() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    await FirebaseAuth.instance.signInWithPopup(githubProvider);
  }

  Future<void> _signInWithGithubForNative(BuildContext context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: const String.fromEnvironment('GITHUB_CLIENT_ID'),
      clientSecret: const String.fromEnvironment('GITHUB_CLIENT_SECRET'),
      redirectUrl: 'https://zazen-release.firebaseapp.com/__/auth/handler',
    );

    final result = await gitHubSignIn.signIn(context);
    final githubToken = result.token!;
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
    final userId = userCredential.user!.uid;

    await _createUserData(userId);
    await _saveGithubToken(githubToken, userId);
  }

  Future<void> _createUserData(String userId) async {
    try {
      await _cloudFirestoreService.setData(
        path: FirestorePath.userDocument(userId),
        data: {
          'userId': userId,
          'createdAt': Timestamp.now(),
        },
      );
    } catch (e) {
      debugPrint('Error in _createUserData(): $e');
    }
  }

  Future<void> _saveGithubToken(String githubToken, String userId) async {
    await _cloudFirestoreService.setData(
      path: FirestorePath.githubTokenDocument(userId),
      data: {
        'data': githubToken,
        'createdAt': Timestamp.now(),
      },
    );
  }
}
