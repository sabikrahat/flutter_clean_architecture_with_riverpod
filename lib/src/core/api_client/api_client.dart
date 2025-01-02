import 'dart:async';
import 'dart:convert';

import '../router/go_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../config/environment.dart';
import '../../features/settings/data/models/settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../features/settings/data/repositories/hive_box.dart';
import '../../injector.dart';
import '../config/constants.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';
import 'enum/method.dart';
import 'model/api_response.dart';
import 'model/auth_store.dart';

final authStoreStreamPd =
    StreamProvider((_) => Boxes.authStores.watch(key: appName.toCamelWord));

class ApiClient {
  AuthStore? authStore;

  Future<void> init() async {
    authStore = Boxes.authStores.get(appName.toCamelWord);
    log.f('AuthStore: $authStore');
    log.f('AuthStore: ${authStore?.isAccessTokenValid}');
    log.f('AuthStore: ${authStore?.isRefreshTokenValid}');
    if (authStore != null && !authStore!.isRefreshTokenValid) {
      await signout();
      log.e('Automatically signed out due to invalid refresh token.');
    } else if (authStore != null && !authStore!.isAccessTokenValid) {
      log.i('Automatically refreshing access token.');
      await _refreshToken();
    }
    _listenForAuthStore();
  }

  void _listenForAuthStore() {
    Boxes.authStores
        .watch(key: appName.toCamelWord)
        .listen((_) => authStore = Boxes.authStores.get(appName.toCamelWord));
  }

  bool get isLoggedIn => authStore != null && authStore!.isAccessTokenValid;

  // Future<void> signup({required Map<String, dynamic> data}) async {
  //   final response = await request(
  //     ApiClientMethod.post,
  //     'auth/signup',
  //     data: data,
  //     isAuthRequired: false,
  //   );
  //   final apiResponse = ApiResponse.fromRawJson(response);
  //   if (!apiResponse.success) throw apiResponse.message;
  //   authStore = AuthStore(
  //     userId: apiResponse.data['id'],
  //     accessToken: apiResponse.data['tokens']['access-token'],
  //     refreshToken: apiResponse.data['tokens']['refresh-token'],
  //   );
  //   await authStore?.saveData();
  // }

  // Future<void> signin({required String email, required String password}) async {
  //   final response = await request(
  //     ApiClientMethod.post,
  //     'auth/login',
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //     isAuthRequired: false,
  //   );
  //   final apiResponse = ApiResponse.fromRawJson(response);
  //   if (!apiResponse.success) throw apiResponse.message;
  //   authStore = AuthStore(
  //     userId: apiResponse.data['id'],
  //     accessToken: apiResponse.data['tokens']['access-token'],
  //     refreshToken: apiResponse.data['tokens']['refresh-token'],
  //   );
  //   await authStore?.saveData();
  // }

  Future<void> signout() async {
    try {
      await authStore?.deleteData();
      authStore = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> get _token async {
    if (authStore == null) return null;
    if (authStore!.isAccessTokenValid) return authStore!.accessToken;
    return await _refreshToken();
  }

  Future<String?> _refreshToken() async {
    if (authStore == null) return null;
    log.f('Refresh token: ${authStore!.refreshToken}');
    if (!authStore!.isRefreshTokenValid) {
      log.i('Both token expired.');
      await signout();
      goRouter.refresh();
      EasyLoading.showToast(
        'Session expired. Please sign in again.',
        toastPosition: EasyLoadingToastPosition.bottom,
      );
      return null;
    }
    log.i('Token refreshing...');
    final response = await request(
      ApiClientMethod.post,
      'auth/refresh-token',
      data: {'refresh-token': authStore!.refreshToken},
      isAuthRequired: false,
    );
    final apiResponse = ApiResponse.fromRawJson(response);
    if (!apiResponse.success) throw apiResponse.message;
    authStore!.accessToken = apiResponse.data['access-token'];
    authStore!.refreshToken = apiResponse.data['refresh-token'];
    log.i('New tokens: ${apiResponse.data}');
    await authStore!.save();
    return authStore!.accessToken;
  }

  Future<String> request(
    ApiClientMethod method,
    String endPoint, {
    Map<String, dynamic>? data,
    bool isAuthRequired = true,
  }) async {
    String? token;
    if (isAuthRequired) {
      token = await _token;
      if (token == null) {
        throw 'Session expired. Please sign in again.';
      }
    }
    final headers = {
      'Content-Type': 'application/json',
      if (isAuthRequired) 'Authorization': 'Bearer $token',
    };
    final url = sl<AppSettings>().isProduction
        ? Environment.prodBaseUrl
        : Environment.devBaseUrl;
    var request = http.Request(method.value, Uri.parse('$url/$endPoint'));
    if (data != null) request.body = json.encode(data);
    request.headers.addAll(headers);

    final response = await request.send();
    final body = await response.stream.bytesToString();
    log.i('Response of $endPoint by $method: $body');
    return body;
  }

  Future<http.StreamedResponse> storeFile(
    List<String> paths, {
    bool isAuthRequired = true,
  }) async {
    String? token;
    if (isAuthRequired) {
      token = await _token;
      if (token == null) {
        throw 'Session expired. Please sign in again.';
      }
    }
    final headers = {'Authorization': 'Bearer $token'};
    final url = sl<AppSettings>().isProduction
        ? Environment.prodBaseUrl
        : Environment.devBaseUrl;
    final request = http.MultipartRequest(
        ApiClientMethod.post.value, Uri.parse('$url/file'));
    for (final path in paths) {
      request.files.add(await http.MultipartFile.fromPath('files', path));
    }
    request.headers.addAll(headers);

    return await request.send();
  }
}
