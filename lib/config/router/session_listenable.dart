import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orda/core/presentation/bloc/session/session_cubit.dart';

class SessionListenable extends ChangeNotifier {
  SessionListenable(Stream<SessionState> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<SessionState> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
