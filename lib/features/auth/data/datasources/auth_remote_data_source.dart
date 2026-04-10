import 'package:orda/core/error/auth_error_mapper.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signInWithPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<User?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user;
    } on AuthException catch (e) {
      final errorMapper = AuthErrorMapper.map(e);
      throw ServerException(errorMapper.message);
    }
  }
}
