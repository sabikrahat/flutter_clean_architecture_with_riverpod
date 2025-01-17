import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/settings/data/models/settings_model.dart';
import '../../injector.dart';
import '../config/environment.dart';
import '../utils/logger/logger_helper.dart';

final authStreamPd =
    StreamProvider((_) => sl<SupabaseClient>().auth.onAuthStateChange);

Future<SupabaseClient> initSupabase() async {
  log.i('Supabase Dev Url: ${Environment.devBaseUrl}');
  log.i('Supabase Dev Anon Key: ${Environment.devAnonKey}');
  log.i('Supabase Prod Url: ${Environment.prodBaseUrl}');
  log.i('Supabase Prod Anon Key: ${Environment.prodAnonKey}');
  final supabase = await Supabase.initialize(
    debug: !sl<AppSettings>().isProduction,
    url: sl<AppSettings>().isProduction
        ? Environment.prodBaseUrl
        : Environment.devBaseUrl,
    anonKey: sl<AppSettings>().isProduction
        ? Environment.prodAnonKey
        : Environment.devAnonKey,
  );
  log.i('Supabase initialized: ${supabase.client.auth.currentUser}');
  return supabase.client;
}