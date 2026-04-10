import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/user/domain/entities/user_profile.dart';
import 'package:orda/features/user/domain/usecases/get_user_profile_use_case.dart';
import 'package:orda/features/user/domain/usecases/sign_out_use_case.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required SignOutUseCase signOut,
    required GetUserProfileUseCase getUserProfile,
  }) : _signOut = signOut,
       _getUserProfile = getUserProfile,
       super(UserInitial()) {
    on<GetUserProfile>(_onGetUserProfile);
    on<SignOut>(_onSignOut);
  }

  final GetUserProfileUseCase _getUserProfile;
  final SignOutUseCase _signOut;

  Future<void> _onGetUserProfile(
    GetUserProfile event,
    Emitter<UserState> emit,
  ) async {
    emit(UserProfileLoading());
    final result = await _getUserProfile();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (userProfile) => emit(UserProfileLoaded(userProfile)),
    );
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<UserState> emit,
  ) async {
    final result = await _signOut();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(SignOutSuccess()),
    );
  }
}
