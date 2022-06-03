import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zazen/auth/auth_service.dart';

import '../../utilities/go_router/router.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authServiceProvider);
    return Scaffold(
      // backgroundColor: Colors.deepPurpleAccent[700],
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lucidity',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () async {
                context.goNamed(AppRoute.dashboard.name);
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
