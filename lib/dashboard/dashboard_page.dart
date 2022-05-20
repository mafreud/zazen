import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zazen/utilities/go_router/router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppBar')),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('hey'),
            ElevatedButton(
              onPressed: () {
                context.goNamed(
                  AppRoute.issueDetail.name,
                  params: {'id': '12345'},
                );
              },
              child: const Text('Go'),
            )
          ],
        ),
      ),
    );
  }
}
