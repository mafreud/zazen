import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zazen/auth/auth_service.dart';

final signInPageViewModelProvider =
    ChangeNotifierProvider<SignInPageViewModel>((ref) {
  return SignInPageViewModel(ref.read);
});

class SignInPageViewModel extends ChangeNotifier {
  SignInPageViewModel(this._read);

  final Reader _read;

  AuthService get _authService => _read(authServiceProvider);

  Future<void> signInWithGithub(BuildContext context) async =>
      await _authService.signInWithGithub(context);
}
