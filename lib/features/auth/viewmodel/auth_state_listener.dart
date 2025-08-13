import 'package:flutter/foundation.dart';
import 'package:flutter_playground/features/auth/model/app_user.dart';
import 'package:flutter_playground/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateListener {
  AuthStateListener(this.ref) {
    _init();
  }

  final Ref ref;

  // Expose the current user as a ValueNotifier
  final ValueNotifier<AppUser?> currentUser = ValueNotifier<AppUser?>(null);

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authUserProvider, (previous, next) {
      final user = next.value;
      debugPrint("HEY ${user?.email}");

      // Update the ValueNotifier for UI or GoRouter
      currentUser.value = user;
    });
  }
}

final authStateListenerProvider = Provider<AuthStateListener>((ref) {
  return AuthStateListener(ref);
});
