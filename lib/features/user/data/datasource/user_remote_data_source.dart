import 'package:orda/core/error/auth_error_mapper.dart';
import 'package:orda/core/error/exceptions.dart';
import 'package:orda/features/user/data/models/user_profile_model.dart';
import 'package:orda/features/user/domain/usecases/change_password_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRemoteDataSource {
  Future<UserProfileModel> getUserProfile();

  Future<void> changePassword(ChangePasswordParams params);

  Future<void> signOut();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<UserProfileModel> getUserProfile() async {
    final currentUser = client.auth.currentUser;

    if (currentUser == null) {
      throw const ServerException('Người dùng chưa đăng nhập');
    }

    final userProfile = await client
        .from('profiles')
        .select()
        .single()
        .withConverter<UserProfileModel>((json) {
          return UserProfileModel.fromJson(currentUser, json);
        });

    return userProfile;
  }

  @override
  Future<void> changePassword(ChangePasswordParams params) async {
    final session = client.auth.currentSession;

    if (session == null) {
      throw const ServerException('Người dùng chưa đăng nhập');
    }

    print(session.user.role);
    print(session.user.appMetadata);
    print(session.user.userMetadata);

    try {
      await client.auth.updateUser(
        UserAttributes(password: params.newPassword),
      );
    } on AuthException catch (e) {
      final errorMapper = AuthErrorMapper.map(e);
      throw ServerException(errorMapper.message);
    }
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
