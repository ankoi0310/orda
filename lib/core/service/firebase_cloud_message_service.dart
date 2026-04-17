import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  NotificationService({
    required FirebaseMessaging firebaseMessage,
    required SupabaseClient supabase,
  }) : _firebaseMessaging = firebaseMessage,
       _supabase = supabase;

  final FirebaseMessaging _firebaseMessaging;
  final SupabaseClient _supabase;

  void init() {
    _firebaseMessaging.onTokenRefresh.listen(_saveFcmToken);
  }

  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission();
  }

  Future<void> setFcmToken() async {
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      await _saveFcmToken(fcmToken);
    }
  }

  Future<void> _saveFcmToken(String fcmToken) async {
    await _supabase.from('profiles').upsert({'fcm_token': fcmToken});
  }
}
