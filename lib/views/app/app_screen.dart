import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.replace('/login');
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
