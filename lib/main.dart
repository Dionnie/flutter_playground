import 'package:flutter/material.dart';
import 'package:flutter_playground/routing/router.dart';
import 'package:flutter_playground/ui/core/scroll_behavior.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:provider/provider.dart';

//import 'main_staging.dart' as staging;
import 'main_development.dart' as development;

void main() {
  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoTransition.defaultCurve = Curves.easeInOut;

    final rootKey = GlobalKey<NavigatorState>();
    final shellKey = GlobalKey<NavigatorState>();

    return MaterialApp.router(
      scrollBehavior: AppCustomScrollBehavior(),
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: GoTransitions.fadeUpwards,
            TargetPlatform.iOS: GoTransitions.cupertino,
            TargetPlatform.macOS: GoTransitions.cupertino,
          },
        ),
        useMaterial3: false,
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      routerConfig: router(context.read(), rootKey, shellKey),
    );
  }
}
