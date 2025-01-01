import 'dart:async';

import '../config/environment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/settings/data/models/settings_model.dart';
import '../../injector.dart';
import '../utils/logger/logger_helper.dart';

final authStreamPd =
    StreamProvider((_) => sl<SupabaseClient>().auth.onAuthStateChange);

Future<SupabaseClient> initSupabase() async {
  await Supabase.initialize(
    debug: !sl<AppSettings>().isProduction,
    url: sl<AppSettings>().isProduction
        ? Environment.prodBaseUrl
        : Environment.devBaseUrl,
    anonKey: sl<AppSettings>().isProduction
        ? Environment.prodAnonKey
        : Environment.devAnonKey,
  );
  log.i(
      'Supabase initialized: ${Supabase.instance.client.auth.currentUser?.toJson()}');
  return Supabase.instance.client;
}
