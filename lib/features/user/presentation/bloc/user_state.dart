part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class LoadingUserProfile extends UserState {}

final class UpdatingUserProfile extends UserState {}

final class UpdatingUserPassword extends UserState {}

final class UserSuccess extends UserState {
  const UserSuccess(this.userProfile);

  final UserProfile userProfile;
}

final class UserUpdatePasswordSuccess extends UserState {}

final class UserSignOutSuccess extends UserState {}

final class UserError extends UserState {
  const UserError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
