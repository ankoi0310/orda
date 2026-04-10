import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/data/datasource/user_remote_data_source.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.remoteDataSource});

  final UserRemoteDataSource remoteDataSource;

  @override
  ResultFuture<UserProfile> getUserProfile() async {
    try {
      final userProfile = await remoteDataSource.getUserProfile();
      return right(userProfile);
    } on ServerException catch (e) {
      return left(ValidationFailure(e.message));
    }
  }

  @override
  VoidFuture signOut() async {
    await remoteDataSource.signOut();
    return right(unit);
  }
}
