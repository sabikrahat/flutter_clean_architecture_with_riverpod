import 'package:dartz/dartz.dart';

import '../../data/models/request/forget_password.dart';
import '../repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository _authRepository;

  ForgetPasswordUseCase(this._authRepository);

  Future<Either> call(ForgetPasswordParams params) async {
    return await _authRepository.forgetPassword(params: params);
  }
}
