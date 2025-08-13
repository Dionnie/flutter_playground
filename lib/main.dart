import 'package:flutter/material.dart';
import 'package:flutter_playground/routing/router.dart';
import 'package:flutter_playground/ui/core/scroll_behavior.dart';
import 'main_development.dart' as development;

void main() {
  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: AppCustomScrollBehavior(),
      theme: ThemeData(
        brightness: Brightness.dark,

        useMaterial3: false,
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      //  routerConfig: router(context.read(), rootKey, shellKey),
      routerConfig: router(),
    );
  }
}
