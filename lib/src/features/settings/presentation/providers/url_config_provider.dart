import 'package:flutter/material.dart';
import '../../../../core/config/environment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injector.dart';
import '../../data/models/settings_model.dart';
import 'settings_provider.dart';

typedef UrlConfigNotifier
    = AutoDisposeNotifierProvider<UrlConfigProvider, void>;

final urlConfigProvider = UrlConfigNotifier(UrlConfigProvider.new);

class UrlConfigProvider extends AutoDisposeNotifier {
  late AppSettings _currSettings;
  late TextEditingController baseUrlCntrlr;
  late TextEditingController anonKeyCntrlr;
  late List<String> _baseUrls;
  late List<String> _anonKeys;
  late List<String> _headers;
  late int _currUrlIndex;

  @override
  build() {
    ref.watch(settingsStreamProvider);
    _currSettings = sl<AppSettings>();
    _baseUrls = [Environment.prodBaseUrl, Environment.devBaseUrl];
    _anonKeys = [Environment.prodAnonKey, Environment.devAnonKey];
    _headers = ['Production', 'Development'];
    _currUrlIndex = _currSettings.isProduction ? 0 : 1;
    baseUrlCntrlr = TextEditingController(
      text: _currSettings.isProduction
          ? Environment.prodBaseUrl
          : Environment.devBaseUrl,
    );
    anonKeyCntrlr = TextEditingController(
      text: _currSettings.isProduction
          ? Environment.prodAnonKey
          : Environment.devAnonKey,
    );
  }

  AppSettings get currSettings => _currSettings;

  List<String> get baseUrls => _baseUrls;

  List<String> get anonKeys => _anonKeys;

  List<String> get headers => _headers;

  int get currUrlIndex => _currUrlIndex;

  void toggleUrl(int? i) {
    if (i == null) return;
    baseUrlCntrlr.text = _baseUrls[i];
    anonKeyCntrlr.text = _anonKeys[i];
    _currUrlIndex = i;
    _currSettings.isProduction = i == 0;
    ref.notifyListeners();
  }

  Future<void> submit() async => await _currSettings.save();
}
