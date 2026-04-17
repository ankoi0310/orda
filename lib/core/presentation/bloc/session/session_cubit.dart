import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda/core/service/firebase_cloud_message_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required SupabaseClient supabase,
    required NotificationService notificationService,
  }) : _supabase = supabase,
       _notificationService = notificationService,
       super(const SessionState()) {
    _init();
  }

  final SupabaseClient _supabase;
  final NotificationService _notificationService;

  StreamSubscription<AuthState>? _sub;

  void _init() {
    final currentUser = _supabase.auth.currentUser;

    if (currentUser != null) {
      emit(state.copyWith(user: currentUser));
    }

    _sub = _supabase.auth.onAuthStateChange.listen((data) async {
      if (data.event == AuthChangeEvent.signedIn) {
        await _notificationService.requestPermission();

        await _notificationService.setFcmToken();
      }

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
