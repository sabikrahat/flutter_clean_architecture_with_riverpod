import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/utils/logger/logger_helper.dart';
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
  final SupabaseClient _supabaseClient;

  AuthRemoteServiceImpl(this._supabaseClient);

  @override
  Future<Either> signin({required SigninParams params}) async {
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(email: params.email, password: params.password);
      log.i('signin response: $response');
      return Right(response);
    } on SocketException catch (e) {
      log.e('signin error: No internet connection. $e');
      return Left('No internet connection. $e');
    } on AuthException catch (e) {
      log.e('signin error: $e');
      return Left(e);
    } catch (e) {
      log.e('signin error: $e');
      return Left(e);
    }
  }

  @override
  Future<Either> signup({required SignupParams params}) async {
    try {
      final resposne = await _supabaseClient.auth.signUp(
        email: params.email,
        password: params.password,
        data: {
          'email': params.email,
          'name': params.name,
          'created': params.created.toUtc().toIso8601String(),
          'updated': params.updated.toUtc().toIso8601String(),
        },
      );
      log.i('signup response: $resposne');
      return Right(resposne);
    } on SocketException catch (e) {
      log.e('signup error: No internet connection. $e');
      return Left('No internet connection. $e');
    } on AuthException catch (e) {
      log.e('signup error: $e');
      return Left(e);
    } catch (e) {
      log.e('signup error: $e');
      return Left(e);
    }
  }

  @override
  Future<Either> forgetPassword({required ForgetPasswordParams params}) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(params.email);
      log.i('Password reset email sent');
      return Right('Password reset email sent');
    } on SocketException catch (e) {
      log.e('forgetPassword error: No internet connection. $e');
      return Left('No internet connection. $e');
    } on AuthException catch (e) {
      log.e('forgetPassword error: $e');
      return Left(e);
    } catch (e) {
      log.e('forgetPassword error: $e');
      return Left(e);
    }
  }

  @override
  Future<Either> signout() async {
    try {
      await _supabaseClient.auth.signOut();
      log.i('Signout successful');
      return Right('Signout successful');
    } on SocketException catch (e) {
      log.e('signout error: No internet connection. $e');
      return Left('No internet connection. $e');
    } on AuthException catch (e) {
      log.e('signout error: $e');
      return Left(e);
    } catch (e) {
      log.e('signout error: $e');
      return Left(e);
    }
  }
}