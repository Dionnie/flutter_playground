import 'package:flutter_playground/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutViewModel extends StateNotifier<AsyncValue<void>> {
  LogoutViewModel(this.ref) : super(const AsyncData(null));
  final Ref ref;

  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await authRepository.logout());
  }
}

final logoutViewModelProvider =
    StateNotifierProvider<LogoutViewModel, AsyncValue<void>>((ref) {
      return LogoutViewModel(ref);
    });
