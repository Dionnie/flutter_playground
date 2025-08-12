import 'package:flutter_playground/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<AsyncValue<void>> {
  LoginViewModel(this.ref) : super(const AsyncData(null));
  final Ref ref;

  Future<void> login(String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => await authRepository.login(email, password),
    );
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<void>>((ref) {
      return LoginViewModel(ref);
    });
