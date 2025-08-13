import 'package:flutter/material.dart';
import 'package:flutter_playground/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authUserAsync = ref.watch(authUserProvider);
    // final currentTime = ref.watch(clockProvider);

    // format the time as `hh:mm:ss`
    // print(currentTime.toLocal().toIso8601String());
    // you can also use DateFormat from intl package to format the time
    // final formattedTime = DateFormat('hh:mm:ss').format(currentTime);
    // print(formattedTime);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            authUserAsync.when(
              data: (user) {
                if (user == null) {
                  return const Center(child: Text("Not logged in"));
                } else {
                  return Center(child: Text("Hello, ${user.email}"));
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error: $err")),
            ),

            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () => context.push('/profile'),
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
