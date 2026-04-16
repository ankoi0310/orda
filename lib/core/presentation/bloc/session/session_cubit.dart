import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient,
      super(const SessionState()) {
    _init();
  }

  final SupabaseClient _supabaseClient;

  StreamSubscription<AuthState>? _sub;

  void _init() {
    final currentUser = _supabaseClient.auth.currentUser;

    if (currentUser != null) {
      emit(state.copyWith(user: currentUser));
    }

    _sub = _supabaseClient.auth.onAuthStateChange.listen((
      data,
    ) async {
      final session = data.session;

      if (session != null) {
        emit(state.copyWith(user: session.user));
      } else {
        emit(const SessionState());
      }
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
