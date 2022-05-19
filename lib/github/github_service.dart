import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sign_in/github_sign_in.dart';

final githubServiceProvider = Provider<GithubService>((_) {
  return GithubService();
});

class GithubService {
  /// returns GithubSignIn Object
  GitHubSignIn get _github {
    return GitHubSignIn(
      clientId: '3',
      clientSecret: '4',
      redirectUrl: 'https://zazen-release.firebaseapp.com/__/auth/handler',
    );
  }

  Future<GitHubSignInResult> signIn(BuildContext context) =>
      _github.signIn(context);
}
