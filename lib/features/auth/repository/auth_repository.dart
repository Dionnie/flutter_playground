import 'package:flutter_playground/features/auth/repository/auth_repository_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_user.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> logout();
  Stream<AppUser?> authStateChanges();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return LocalAuthRepository();
});
