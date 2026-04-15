import 'package:fpdart/fpdart.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/core/error/failure.dart';
import 'package:orda/core/utils/typedefs.dart';
import 'package:orda/features/user/data/datasource/user_remote_data_source.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';
import 'package:orda/features/user/domain/repositories/user_repository.dart';
import 'package:orda/features/user/domain/usecases/change_password_use_case.dart';

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
  VoidFuture changePassword(ChangePasswordParams params) async {
    try {
      await remoteDataSource.changePassword(params);
      return right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Đổi mật khẩu không thành công: $e'));
    }
  }

  @override
  VoidFuture signOut() async {
    await remoteDataSource.signOut();
    return right(unit);
  }
}
