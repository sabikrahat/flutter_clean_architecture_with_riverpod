import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/logger/logger_helper.dart';
import '../../../../injector.dart';
import '../../data/models/settings_model.dart';
import '../../data/repositories/hive_box.dart';

final settingsStream = Boxes.appSettings
    .watch(key: appName.toCamelWord)
    .map((event) => event.value as AppSettings);

final settingsStreamProvider = StreamProvider((_) => settingsStream);

typedef AppSettingsNotifier = NotifierProvider<SettingProvider, AppSettings>;

final settingsProvider = AppSettingsNotifier(SettingProvider.new);

class SettingProvider extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.watch(settingsStreamProvider).value ?? sl<AppSettings>();

  Future<bool> changeInitSetting(AppSettings setting) async {
    log.i('First Time Run. Initializing...');
    await setting.saveData();
    state = setting;
    return true;
  }
}
