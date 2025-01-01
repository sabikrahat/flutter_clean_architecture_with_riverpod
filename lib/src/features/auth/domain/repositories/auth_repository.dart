import 'package:dartz/dartz.dart';

import '../../data/models/request/forget_password.dart';
import '../../data/models/request/signin.dart';
import '../../data/models/request/signup.dart';

abstract class AuthRepository {
  Future<Either> signin({required SigninParams params});
  Future<Either> signup({required SignupParams params});
  Future<Either> forgetPassword({required ForgetPasswordParams params});
  Future<Either> signout();
}
