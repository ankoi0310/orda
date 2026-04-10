import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required SignInWithPasswordUseCase signInWithPassword})
    : _signInWithPassword = signInWithPassword,
      super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<SignInWithPassword>(_onSignInWithPassword);
  }

  final SignInWithPasswordUseCase _signInWithPassword;

  Future<void> _onSignInWithPassword(
    SignInWithPassword event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInWithPassword(
      SignInWithPasswordParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
