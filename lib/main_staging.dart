// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_playground/common/shared_preference_provider.dart';
import 'package:flutter_playground/features/auth/repository/auth_repository.dart';
import 'package:flutter_playground/features/auth/repository/auth_repository_remote.dart';
import 'package:flutter_playground/features/auth/viewmodel/auth_state_listener.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'main.dart';

/// Development config entry point.
/// Launch with `flutter run --target lib/main_development.dart`.
/// Uses local data.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  final sharedPreferences = await SharedPreferences.getInstance();

  final supabase = await Supabase.initialize(
    url: "http://127.0.0.1:54321",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ",
  );

  // 1. Create a ProviderContainer
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      authRepositoryProvider.overrideWithValue(
        RemoteAuthRepository(supabase.client),
      ),
    ],
  );
  // 2. Use it to read the provider
  container.read(authStateListenerProvider);
  // 3. Pass the container to an UncontrolledProviderScope and run the app

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MainApp(container: container),
    ),
  );
}
