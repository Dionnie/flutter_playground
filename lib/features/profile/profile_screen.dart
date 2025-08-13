import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile Screen'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
