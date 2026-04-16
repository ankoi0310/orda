part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState({this.user});

  final User? user;

  bool get isAuthenticated => user != null;

  SessionState copyWith({User? user}) {
    return SessionState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [user];
}
