import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.supabaseClient)
    : super(AuthSessionInitial()) {
    checkUserSession();
  }

  final SupabaseClient supabaseClient;

  void checkUserSession() {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser != null) {
      emit(Authenticated(currentUser));
    } else {
      emit(Unauthenticated());
    }

    supabaseClient.auth.onAuthStateChange.listen((data) {
      final session = data.session;

      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
