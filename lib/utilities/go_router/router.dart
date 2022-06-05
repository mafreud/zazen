import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zazen/dashboard/issue/issue_detail_page.dart';

import '../../auth/sign_in/sign_in_page.dart';
import '../../dashboard/dashboard_page.dart';
import '../../error/error_page.dart';

enum AppRoute { root, signIn, dashboard, issueDetail }

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.root.name,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/signIn',
      name: AppRoute.signIn.name,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: AppRoute.dashboard.name,
      builder: (context, state) => const DashboardPage(),
      routes: [
        GoRoute(
          path: 'issueDetail/:id',
          name: AppRoute.issueDetail.name,
          pageBuilder: (context, state) {
            final issueId = state.params['id']!;
            return MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: IssueDetailPage(
                issueId: issueId,
              ),
            );
          },
        ),
      ],
    )
  ],
  errorBuilder: (context, state) => ErrorPage(exception: state.error),
  urlPathStrategy: UrlPathStrategy.path,
);
