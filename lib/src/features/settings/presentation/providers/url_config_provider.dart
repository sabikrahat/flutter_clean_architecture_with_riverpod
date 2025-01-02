import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/environment.dart';
import '../../../../injector.dart';
import '../../data/models/settings_model.dart';
import 'settings_provider.dart';

typedef UrlConfigNotifier
    = AutoDisposeNotifierProvider<UrlConfigProvider, void>;

final urlConfigProvider = UrlConfigNotifier(UrlConfigProvider.new);

class UrlConfigProvider extends AutoDisposeNotifier {
  late AppSettings _currSettings;
  late TextEditingController baseUrlCntrlr;
  late List<String> _baseUrls;
  late List<String> _anonKeys;
  late List<String> _headers;
  late int _currUrlIndex;

  @override
  build() {
    ref.watch(settingsStreamProvider);
    _currSettings = sl<AppSettings>();
    _baseUrls = [Environment.prodBaseUrl, Environment.devBaseUrl];
    _headers = ['Production', 'Development'];
    _currUrlIndex = _currSettings.isProduction ? 0 : 1;
    baseUrlCntrlr = TextEditingController(
      text: _currSettings.isProduction
          ? Environment.prodBaseUrl
          : Environment.devBaseUrl,
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
    _currUrlIndex = i;
    _currSettings.isProduction = i == 0;
    ref.notifyListeners();
  }

  Future<void> submit() async => await _currSettings.save();
}
