// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter_playground/features/profile/profile_screen.dart';
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

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router() => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.login,
  debugLogDiagnostics: true,
  //redirect: _redirect,
  // refreshListenable: authRepository,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen();
      },
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (_, __, child) => AppScreen(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => HomeScreen()),

        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
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
