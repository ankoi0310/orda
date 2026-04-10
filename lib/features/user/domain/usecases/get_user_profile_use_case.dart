import 'package:orda/core/usecase/usecase.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';

class GetUserProfileUseCase
    implements UseCaseWithoutParams<UserProfile> {
  const GetUserProfileUseCase({required this.repository});

  final UserRepository repository;

  @override
  ResultFuture<UserProfile> call() async {
    return repository.getUserProfile();
  }
}
