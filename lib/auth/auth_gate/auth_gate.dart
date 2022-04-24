import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zazen/auth/sign_in/sign_in_page.dart';
import 'package:zazen/onboarding/onboarding_page.dart';

import '../auth_service.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateStream = ref.watch(authStateStreamProvider);

    return authStateStream.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
      data: (user) {
        if (user == null) {
          return const OnboardingPage();
        }
        return const SignInPage();
      },
    );
  }
}
