import 'package:dartz/dartz.dart';

import '../../domain/repository/auth_repository.dart';
import '../models/request/forget_password.dart';
import '../models/request/signin.dart';
import '../models/request/signup.dart';
import '../sources/remote/auth_remote_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteService _authRemoteService;

  AuthRepositoryImpl(this._authRemoteService);

  @override
  Future<Either> signin({required SigninParams params}) async {
    final response = await _authRemoteService.signin(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either> signup({required SignupParams params}) async {
    final response = await _authRemoteService.signup(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either> forgetPassword({required ForgetPasswordParams params}) async {
    final response = await _authRemoteService.forgetPassword(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either> signout() async {
    final response = await _authRemoteService.signout();
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
