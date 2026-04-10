import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String supabaseUrl = dotenv.get('SUPABASE_URL');
  static final String supabasePublishableKey = dotenv.get(
    'SUPABASE_PUBLISHABLE_KEY',
  );
}
