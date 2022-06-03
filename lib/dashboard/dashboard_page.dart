import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        title: const Text('Dashboard - where issues get together'),
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Create a GitHubSignIn instance
                final GitHubSignIn gitHubSignIn = GitHubSignIn(
                  clientId: const String.fromEnvironment('GITHUB_CLIENT_ID'),
                  clientSecret:
                      const String.fromEnvironment('GITHUB_CLIENT_SECRET'),
                  redirectUrl:
                      'https://zazen-release.firebaseapp.com/__/auth/handler',
                );

                // Trigger the sign-in flow
                final result = await gitHubSignIn.signIn(context);

                // Create a credential from the access token
                final githubAuthCredential =
                    GithubAuthProvider.credential(result.token!);

                // Once signed in, return the UserCredential
                await FirebaseAuth.instance
                    .signInWithCredential(githubAuthCredential);
              },
              child: const Text('native login'),
            ),
            ElevatedButton(
              onPressed: () async {
                GithubAuthProvider githubProvider = GithubAuthProvider();

                await FirebaseAuth.instance.signInWithPopup(githubProvider);
              },
              child: const Text('fetch'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                print(user!.uid);
              },
              child: const Text('fetch'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                FirebaseAuth.instance.signOut();
              },
              child: const Text('signout'),
            ),
          ],
        ),
      ),
    );
  }
}
