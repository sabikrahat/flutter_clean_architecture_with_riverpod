import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/app.dart' show App;
import 'src/core/api_client/api_client.dart';
import 'src/core/config/environment.dart';
import 'src/core/config/get_platform.dart';
import 'src/core/utils/themes/themes.dart';
import 'src/features/settings/data/repositories/hive_repository_impl.dart';
import 'src/features/settings/data/repositories/settings_repository_impl.dart';
import 'src/injector.dart';

const isProduction = false;

void main() async {
  await _init();
  runApp(const ProviderScope(child: App()));
}

Future<void> _init() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await dotenv.load(fileName: Environment.fileName);
  await initializeServiceLocator();
  await HiveRepositoryImpl().init();
  await SettingsRepositoryImpl().init();
  await sl<ApiClient>().init();
  await _initFastCachedImageConfig();
  // usePathUrlStrategy();
  FlutterNativeSplash.remove();
}

Future<void> _initFastCachedImageConfig() async {
  await FastCachedImageConfig.init(
    subDir: sl<PT>().isWeb ? '' : sl<AppDir>().files.path,
    clearCacheAfter: const Duration(days: 30),
  );
}

void configEasyLoading(BuildContext context) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.transparent
    ..boxShadow = const <BoxShadow>[]
    ..indicatorColor = kPrimaryColor
    ..progressColor = kPrimaryColor
    ..textColor = Colors.white
    ..textStyle = const TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    )
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withValues(alpha: 0.8)
    ..indicatorWidget = const SizedBox(
      height: 70.0,
      width: 70.0,
      child: SpinKitThreeBounce(color: kPrimaryColor, size: 30.0),
    )
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}


// import 'dart:async';
// import 'package:auth/common/widgets/error/app_error_view.dart';
// import 'package:auth/core/logger/logger.dart';
// import 'package:auth/injector.dart' as dep;
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

// class Initializer {
//   Initializer._();

//   static void init(VoidCallback runApp) {
//     ErrorWidget.builder = (errorDetails) {
//       return AppErrorView(
//         message: errorDetails.exceptionAsString(),
//       );
//     };

//     runZonedGuarded(() async {
//       WidgetsFlutterBinding.ensureInitialized();
//       FlutterError.onError = (details) {
//         FlutterError.dumpErrorToConsole(details);
//         logger.e(details.stack.toString()); //Error log
//       };

//       await _initServices();

//       runApp();
//     }, (error, stack) {
//       logger.e('runZonedGuarded: ${error.toString()}'); //Error log
//     });
//   }

//   static Future<void> _initServices() async {
//     try {
//       _initScreenPreference();

//       await _dependencyInjection();
//     } catch (err) {
//       rethrow;
//     }
//   }

//   static Future<void> _dependencyInjection() async {
//     await dep.initialize();
//   }

//   static void _initScreenPreference() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }
// }