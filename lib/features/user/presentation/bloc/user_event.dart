part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class GetUserProfile extends UserEvent {}

final class SignOut extends UserEvent {}
