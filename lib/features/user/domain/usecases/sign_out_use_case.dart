import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';

class SignOutUseCase implements UseCaseWithoutParams<void> {
  const SignOutUseCase({required this.repository});

  final UserRepository repository;

  @override
  ResultFuture<void> call() async {
    return repository.signOut();
  }
}
