import 'package:dartz/dartz.dart';

import '../../data/models/request/signin.dart';
import '../repositories/auth_repository.dart';

class SigninUseCase {
  final AuthRepository _authRepository;

  SigninUseCase(this._authRepository);

  Future<Either> call(SigninParams params) async {
    return await _authRepository.signin(params: params);
  }
}
