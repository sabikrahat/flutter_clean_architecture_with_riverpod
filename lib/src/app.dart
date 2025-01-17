import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/router/go_router.dart';
import 'features/home/presentation/view/home.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../main.dart';
import 'core/config/constants.dart' show appName;
import 'core/config/size.dart';
import 'core/shared/internet/view/internet.dart';
import 'core/utils/extensions/extensions.dart';
import 'core/utils/logger/logger_helper.dart';
import 'core/utils/themes/dark/dark.theme.dart';
import 'core/utils/themes/light/light.theme.dart';
import 'features/settings/data/models/locale/locale_model.dart';
import 'features/settings/data/models/theme/theme_model.dart';
import 'features/settings/presentation/providers/locale_provider.dart';
import 'features/settings/presentation/providers/performance_overlay_provider.dart';
import 'features/settings/presentation/providers/theme_provider.dart';
import 'localization/loalization.dart'
    show localizationsDelegates, onGenerateTitle, t;

class App extends ConsumerWidget {
  const App({super.key = const Key(appName)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    configEasyLoading(context);
    return MaterialApp.router(
      title: appName,
      theme: _themeData(context, ref),
      routerConfig: goRouter,
      onGenerateTitle: onGenerateTitle,
      debugShowCheckedModeBanner: false,
      restorationScopeId: appName.toCamelWord,
      locale: ref.watch(localeProvider).locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      showPerformanceOverlay: ref.watch(performanceOverlayProvider),
      builder: EasyLoading.init(builder: (ctx, child) {
        t = AppLocalizations.of(ctx)!;
        topBarSize = ctx.padding.top;
        bottomViewPadding = ctx.padding.bottom;
        log.i('App build. Height: ${ctx.height} px, Width: ${ctx.width} px');
        return MediaQuery(
          data: ctx.mq.copyWith(
            devicePixelRatio: 1.0,
            textScaler: const TextScaler.linear(1.0),
          ),
          child: InternetWidget(child: child ?? const HomeView()),
        );
      }),
    );
  }
}

ThemeData _themeData(BuildContext context, WidgetRef ref) {
  final t = ref.watch(themeProvider);
  final theme = t.isSystem
      ? (context.isLightTheme ? lightTheme : darkTheme)
      : t.isDark
          ? darkTheme
          : lightTheme;

  SystemChrome.setSystemUIOverlayStyle(
    t.isSystem
        ? (context.isLightTheme ? lightUiConfig : darkUiConfig)
        : t.isDark
            ? darkUiConfig
            : lightUiConfig,
  );
  return theme;
}
