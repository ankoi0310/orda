import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInWithPasswordUseCase
    implements UseCase<User?, SignInWithPasswordParams> {
  const SignInWithPasswordUseCase({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<User?> call(SignInWithPasswordParams params) async {
    return repository.signInWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithPasswordParams {
  const SignInWithPasswordParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
