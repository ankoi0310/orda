import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';

abstract class UserRepository {
  ResultFuture<UserProfile> getUserProfile();
  VoidFuture signOut();
}
