import 'package:flutter/material.dart';
import 'package:flutter_playground/features/auth/viewmodel/logout_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppScreen extends ConsumerStatefulWidget {
  const AppScreen({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends ConsumerState<AppScreen> {
  @override
  Widget build(BuildContext context) {
    final logoutController = ref.read(logoutViewModelProvider.notifier);

    return Scaffold(
      body: widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await logoutController.logout();
          // context.replace('/login');
        },
        label: Text('Outer Screen ${GoRouterState.of(context).uri.toString()}'),
        icon: const Icon(Icons.switch_access_shortcut_add_outlined),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: [
          '/',
          '/shop',
          '/settings',
        ].indexOf(GoRouterState.of(context).uri.toString()).clamp(0, 2),
        onTap: (value) {
          switch (value) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/shop');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'Screen1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Screen2',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: 'Screen3'),
        ],
      ),
    );
  }
}
