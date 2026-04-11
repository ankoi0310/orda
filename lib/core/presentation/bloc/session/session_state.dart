part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class AuthSessionInitial extends SessionState {}

final class Authenticated extends SessionState {
  const Authenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

final class Unauthenticated extends SessionState {}
