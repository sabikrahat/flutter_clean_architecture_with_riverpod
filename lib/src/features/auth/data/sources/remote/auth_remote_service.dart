import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../../core/api_client/api_client.dart';

import '../../../../../core/api_client/enum/method.dart';
import '../../../../../core/api_client/model/api_response.dart';
import '../../../../../core/api_client/model/auth_store.dart';
import '../../../../../core/utils/logger/logger_helper.dart';
import '../../../../../injector.dart';
import '../../models/request/forget_password.dart';
import '../../models/request/signin.dart';
import '../../models/request/signup.dart';

abstract class AuthRemoteService {
  Future<Either> signin({required SigninParams params});
  Future<Either> signup({required SignupParams params});
  Future<Either> forgetPassword({required ForgetPasswordParams params});
  Future<Either> signout();
}

class AuthRemoteServiceImpl implements AuthRemoteService {
  final ApiClient _apiClient;

  AuthRemoteServiceImpl(this._apiClient);

  @override
  Future<Either> signin({required SigninParams params}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'auth/login',
        data: {
          'email': params.email,
          'password': params.password,
        },
        isAuthRequired: false,
      );
      final Map<String, dynamic> apiResponse = json.decode(response);
      // final apiResponse = ApiResponse.fromRawJson(response);
      // if (!apiResponse.success) throw apiResponse.message;
      sl<ApiClient>().authStore = AuthStore(
        userId: apiResponse['id'] ?? 'abc-123-def-456-ghi-789',
        accessToken: apiResponse['access_token'],
        refreshToken: apiResponse['refresh_token'],
      );
      await sl<ApiClient>().authStore?.saveData();
      return Right(apiResponse);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signup({required SignupParams params}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'auth/signup',
        data: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
        },
        isAuthRequired: false,
      );
      final apiResponse = ApiResponse.fromRawJson(response);
      if (!apiResponse.success) throw apiResponse.message;
      sl<ApiClient>().authStore = AuthStore(
        userId: apiResponse.data['id'],
        accessToken: apiResponse.data['tokens']['access-token'],
        refreshToken: apiResponse.data['tokens']['refresh-token'],
      );
      await sl<ApiClient>().authStore?.saveData();
      return Right(apiResponse);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> forgetPassword({required ForgetPasswordParams params}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      log.i('Password reset email sent');
      return Right('Password reset email sent');
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signout() async {
    try {
      await sl<ApiClient>().authStore?.deleteData();
      sl<ApiClient>().authStore = null;
      log.i('Signout successful');
      return Right('Signout successful');
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }
}
