// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter_playground/views/app/app_screen.dart';
import 'package:flutter_playground/features/auth/login_screen.dart';
import 'package:flutter_playground/views/home/home_screen.dart';
import 'package:flutter_playground/views/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user
/// to /login when the user logs out.

GoRouter router(
  // AuthRepository authRepository,
  GlobalKey<NavigatorState>? rootKey,
  GlobalKey<NavigatorState>? shellKey,
) => GoRouter(
  navigatorKey: rootKey,
  initialLocation: Routes.login,
  debugLogDiagnostics: true,
  //redirect: _redirect,
  // refreshListenable: authRepository,
  routes: [
    GoRoute(
      parentNavigatorKey: rootKey,
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen();
      },
    ),

    ShellRoute(
      navigatorKey: shellKey,
      builder: (_, __, child) => AppScreen(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: shellKey,
          path: '/',
          builder: (_, __) => HomeScreen(),
        ),

        GoRoute(
          parentNavigatorKey: shellKey,
          path: '/settings',
          builder: (_, __) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
/* Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;
  if (!loggedIn) {
    return Routes.login;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (loggingIn) {
    return Routes.home;
  }

  // no need to redirect at all
  return null;
}
 */
