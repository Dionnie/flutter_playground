import 'dart:async';

import 'package:flutter_playground/features/auth/model/app_user.dart';

import 'auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  final _controller = StreamController<AppUser?>.broadcast();

  @override
  Future<void> login(String email, String password) async {
    if (email == "email@example.com" && password == "password") {
      _controller.add(AppUser(id: "mock_id", email: email));
    } else {
      throw Exception("Mock: Invalid credentials");
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Stream<AppUser?> authStateChanges() => _controller.stream;
}
