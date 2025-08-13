import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/app_user.dart';
import 'auth_repository.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<void> login(String email, String password) async {
    final res = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.user == null) {
      throw Exception("Invalid credentials");
    }
  }

  @override
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  @override
  Stream<AppUser?> currentUserStream() {
    return _supabase.auth.onAuthStateChange.map((event) {
      final u = event.session?.user;
      return u == null ? null : AppUser(id: u.id, email: u.email);
    });
  }
}
