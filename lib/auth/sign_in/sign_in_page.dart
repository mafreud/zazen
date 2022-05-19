import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zazen/auth/auth_service.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authServiceProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF1F2023),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Zazen - a better alternative of Zenhub',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.signInWithGithub(context);
              },
              child: const Text(
                'Sign in with Github',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'サインインすることで当サービスの\n利用規約とプライバシーポリシーに同意したことになります',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
