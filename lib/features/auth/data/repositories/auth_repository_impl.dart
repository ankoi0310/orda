import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:orda/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

  @override
  ResultFuture<User?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
