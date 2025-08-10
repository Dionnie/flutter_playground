import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_playground/utils/result.dart';
import 'auth_repository.dart';

class AuthRepositoryRemote extends AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isAuthenticated = false;
  bool _listenerInitialized = false;

  @override
  Future<bool> get isAuthenticated async {
    if (_supabase.auth.currentUser != null) {
      _isAuthenticated = true;
    }

    if (!_listenerInitialized) {
      _supabase.auth.onAuthStateChange.listen((data) {
        final event = data.event;
        _isAuthenticated = event == AuthChangeEvent.signedIn;
        notifyListeners();
      });
      _listenerInitialized = true;
    }

    return _isAuthenticated;
  }

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        _isAuthenticated = true;
        notifyListeners();
        return const Result.ok(null);
      } else {
        return Result.error(Exception('Login failed'));
      }
    } on AuthException catch (e) {
      return Result.error(Exception(e.message));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _supabase.auth.signOut();
      _isAuthenticated = false;
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
