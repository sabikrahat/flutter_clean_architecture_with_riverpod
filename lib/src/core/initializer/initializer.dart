import 'dart:async';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture_template/src/core/api_client/api_client.dart';
import 'package:flutter_clean_architecture_template/src/core/config/environment.dart';
import 'package:flutter_clean_architecture_template/src/core/config/get_platform.dart';
import 'package:flutter_clean_architecture_template/src/core/shared/error_view/error_view.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/logger/logger_helper.dart';
import 'package:flutter_clean_architecture_template/src/features/settings/data/repositories/hive_repository_impl.dart';
import 'package:flutter_clean_architecture_template/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_clean_architecture_template/src/injector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

class Initializer {
  Initializer._();

  static void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return ErrorView(
        message: errorDetails.exceptionAsString(),
      );
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        log.i(details.stack.toString());
      };

      // Native Slpash
      FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
      );

      // Initialize Services
      await _initServices();

      // Remove Native Slpash
      FlutterNativeSplash.remove();
      runApp();
    }, (error, stack) {
      log.i('runZonedGuarded: ${error.toString()}');
    });
  }

  static Future<void> _initServices() async {
    try {
      _initScreenPreference();
      await dotenv.load(fileName: Environment.fileName);
      await initializeServiceLocator();
      await HiveRepositoryImpl().init();
      await SettingsRepositoryImpl().init();
      await sl<ApiClient>().init();
      await _initFastCachedImageConfig();
      if (sl<PT>().isWeb) setUrlStrategy(PathUrlStrategy());
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initFastCachedImageConfig() async {
    await FastCachedImageConfig.init(
      subDir: sl<PT>().isWeb ? '' : sl<AppDir>().files.path,
      clearCacheAfter: const Duration(days: 30),
    );
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
