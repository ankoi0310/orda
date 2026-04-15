import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';
import 'package:orda/features/user/domain/usecases/change_password_use_case.dart';
import 'package:orda/features/user/domain/usecases/get_user_profile_use_case.dart';
import 'package:orda/features/user/domain/usecases/sign_out_use_case.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required SignOutUseCase signOut,
    required ChangePasswordUseCase changePassword,
    required GetUserProfileUseCase getUserProfile,
  }) : _signOut = signOut,
       _changePassword = changePassword,
       _getUserProfile = getUserProfile,
       super(UserInitial()) {
    on<GetUserProfile>(_onGetUserProfile);
    on<SignOut>(_onSignOut);
    on<ChangePassword>(_onChangePassword);
  }

  final GetUserProfileUseCase _getUserProfile;
  final ChangePasswordUseCase _changePassword;
  final SignOutUseCase _signOut;

  Future<void> _onGetUserProfile(
    GetUserProfile event,
    Emitter<UserState> emit,
  ) async {
    emit(LoadingUserProfile());
    final result = await _getUserProfile();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (userProfile) => emit(UserSuccess(userProfile)),
    );
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<UserState> emit,
  ) async {
    emit(UpdatingUserPassword());
    final result = await _changePassword(event.params);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(UserUpdatePasswordSuccess()),
    );
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<UserState> emit,
  ) async {
    final result = await _signOut();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(UserSignOutSuccess()),
    );
  }
}
