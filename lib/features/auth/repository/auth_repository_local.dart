import 'dart:async';

import 'package:flutter_playground/features/auth/model/app_user.dart';

import 'auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  final _controller = StreamController<AppUser?>.broadcast();

  @override
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _controller.add(AppUser(id: "mock_id", email: email));
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _controller.add(null);
  }

  @override
  Stream<AppUser?> currentUserStream() => _controller.stream;

  // Optional: dispose method to close the controller
  void dispose() {
    _controller.close();
  }
}
