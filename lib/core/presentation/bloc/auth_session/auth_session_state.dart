part of 'auth_session_cubit.dart';

sealed class AuthSessionState extends Equatable {
  const AuthSessionState();

  @override
  List<Object> get props => [];
}

final class AuthSessionInitial extends AuthSessionState {}

final class Authenticated extends AuthSessionState {
  const Authenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

final class Unauthenticated extends AuthSessionState {}
