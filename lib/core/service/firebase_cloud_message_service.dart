import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  NotificationService({required SupabaseClient supabase})
    : _supabase = supabase;

  final SupabaseClient _supabase;

  void init() {
    FirebaseMessaging.instance.onTokenRefresh.listen(_saveFcmToken);
  }

  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> setFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await _saveFcmToken(fcmToken);
    }
  }

  Future<void> _saveFcmToken(String fcmToken) async {
    await _supabase.from('profiles').upsert({
      'id': _supabase.auth.currentUser!.id,
      'fcm_token': fcmToken,
    });
  }
}
