import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_auth/simple_auth.dart';
import 'package:zazen/auth/sign_in/sign_in_page_view_model.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

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
                var api = simpleAuth.GithubApi(
                    "github",
                    "6fffbe9e8eb6c01a65e4",
                    "96afd1f6528b81a3927b4e6e89598be86ba6b74e",
                    "https://zazen-release.firebaseapp.com/__/auth/handler",
                    scopes: ['read']);
                var request = Request(
                    HttpMethod.Get, "https://github.com/login/oauth/authorize");
                var userInfo = await api.send<dynamic>(request);
                print(userInfo);
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
