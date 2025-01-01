import 'package:flutter/material.dart';

import '../../../features/settings/data/models/settings_model.dart';
import '../../../features/settings/data/models/theme/theme_model.dart';
import '../../../features/settings/data/repositories/hive_box.dart';
import '../../config/constants.dart';
import '../extensions/extensions.dart';

String get fontFamily =>
    Boxes.appSettings.get(appName.toCamelWord, defaultValue: AppSettings())!.fontFamily;

ThemeProfile get themeType =>
    Boxes.appSettings.get(appName.toCamelWord, defaultValue: AppSettings())!.theme;

const Color white = Colors.white;
const Color black = Colors.black;
const Color transparent = Colors.transparent;

const Color kPrimaryColor = Color(0xFF19478D);
const Color kSecondaryColor = Color(0xFFFF981F);
