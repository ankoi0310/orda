import 'package:orda/core/utils/typedefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  ResultFuture<User?> signInWithPassword({
    required String email,
    required String password,
  });
}
