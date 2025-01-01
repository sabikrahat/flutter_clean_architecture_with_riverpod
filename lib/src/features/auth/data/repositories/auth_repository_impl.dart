import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../injector.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signin(String email, String password) async {
    try {
      await sl<SupabaseClient>()
          .auth
          .signInWithPassword(email: email, password: password);
    } on SocketException catch (e) {
      throw Exception('No internet connection. $e');
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> signup(String email, String password) async {
    try {
      await sl<SupabaseClient>().auth.signUp(email: email, password: password);
    } on SocketException catch (e) {
      throw Exception('No internet connection. $e');
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await sl<SupabaseClient>().auth.resetPasswordForEmail(email);
    } on SocketException catch (e) {
      throw Exception('No internet connection. $e');
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> signout() async {
    try {
      await sl<SupabaseClient>().auth.signOut();
    } on SocketException catch (e) {
      throw Exception('No internet connection. $e');
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      return;
    }
  }
}
