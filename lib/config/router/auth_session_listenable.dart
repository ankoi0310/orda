import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orda/core/presentation/bloc/auth_session/auth_session_cubit.dart';

class AuthSessionListenable extends ChangeNotifier {
  AuthSessionListenable(Stream<AuthSessionState> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthSessionState> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
