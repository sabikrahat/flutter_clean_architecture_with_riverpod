import 'package:flutter_clean_architecture_template/src/core/supabase/init.dart';
import 'package:get_it/get_it.dart';

import 'core/config/get_platform.dart';
import 'features/settings/data/models/settings_model.dart';
import 'features/settings/data/repositories/hive_repository_impl.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeServiceLocator() async {
  sl.registerSingleton<PT>(PlatformInfo.getCurrentPlatformType());
  sl.registerSingleton<AppDir>(AppDir());
  sl.registerSingleton<AppSettings>(AppSettings());
  sl.registerSingletonAsync(() async => await initSupabase());
}
