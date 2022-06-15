import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zazen/auth/sign_in/sign_in_page_view_model.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signInPageViewModelProvider);
    return Scaffold(
      // backgroundColor: Colors.deepPurpleAccent[700],
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '座禅 - zazen',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () async {
                await viewModel.signInWithGithub(context);
              },
              child: const Text(
                'Sign in with Github',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('サインインすることで当サービスの\n利用規約とプライバシーポリシーに同意したことになります',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
