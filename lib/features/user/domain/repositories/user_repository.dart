import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';
import 'package:orda/features/user/domain/usecases/change_password_use_case.dart';

abstract class UserRepository {
  ResultFuture<UserProfile> getUserProfile();

  VoidFuture changePassword(ChangePasswordParams params);

  VoidFuture signOut();
}
