part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserProfileLoading extends UserState {}

final class UserProfileLoaded extends UserState {
  const UserProfileLoaded(this.userProfile);

  final UserProfile userProfile;
}

final class SignOutSuccess extends UserState {}

final class UserError extends UserState {
  const UserError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
