import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'viewmodel/login_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'email@example.com');
    _passwordController = TextEditingController(text: 'password');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginController = ref.read(loginViewModelProvider.notifier);

    ref.listen(loginViewModelProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          //   context.go(Routes.home);
        },
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(
                Icons.lock_outline_rounded,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please sign in to continue",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: loginState.isLoading
                      ? null
                      : () {
                          loginController.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                  child: loginState.isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Login", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
