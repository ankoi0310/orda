import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';

class ChangePasswordUseCase
    implements UseCase<void, ChangePasswordParams> {
  const ChangePasswordUseCase({required this.repository});

  final UserRepository repository;

  @override
  VoidFuture call(ChangePasswordParams params) async {
    return repository.changePassword(params);
  }
}

class ChangePasswordParams {
  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;
}
