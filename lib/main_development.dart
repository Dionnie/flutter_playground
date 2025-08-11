// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/dependencies.dart';
import 'main.dart';

/// Development config entry point.
/// Launch with `flutter run --target lib/main_development.dart`.
/// Uses local data.
Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
  final log = Logger('main_development');

  //?6ZW69Jfi6EG#cd

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: "http://127.0.0.1:54321",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ",
    );
  } catch (e) {
    log.severe('Supabase initialization failed: $e');
  }

  runApp(MultiProvider(providers: providersLocal, child: const MainApp()));
}
