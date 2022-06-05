// 📦 Package imports:
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sign_in/github_sign_in.dart';

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

  Future<void> signOut() async => await _firebaseAuthService.signOut;

  Stream<User?> get authStateStream => _firebaseAuthService.authStateStream;

  String? get currentUserId => _firebaseAuthService.currentUserId;

  Future<void> signInWithGithub(BuildContext context) async {
    if (kIsWeb) {
      await _signInWithGithubForWeb(context);
    } else if (Platform.isAndroid || Platform.isIOS) {
      await _signInWithGithubForNative(context);
    }
  }

  Future<void> _signInWithGithubForWeb(BuildContext context) async {
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

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
  }
}
