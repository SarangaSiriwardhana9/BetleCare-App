import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientManager {
  static SupabaseClientManager? _instance;
  late final SupabaseClient _supabaseClient;

  SupabaseClientManager._();

  static Future<SupabaseClientManager> get instance async {
    if (_instance == null) {
      await Supabase.initialize(
        url: 'https://oyqrfqhmtdddmijfhgnj.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im95cXJmcWhtdGRkZG1pamZoZ25qIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzMDM2MzQsImV4cCI6MjA1NDg3OTYzNH0.XOmlkG67inp5lLeKtxjw2Y_kUY48Qj9altNf8xtMCLE',
      );
      _instance = SupabaseClientManager._();
      _instance!._supabaseClient = Supabase.instance.client;
    }
    return _instance!;
  }

  SupabaseClient get client => _supabaseClient;
}

