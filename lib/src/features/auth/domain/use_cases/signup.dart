import 'package:dartz/dartz.dart';

import '../../data/models/request/signup.dart';
import '../repository/auth_repository.dart';

class SignupUseCase {
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  Future<Either> call(SignupParams params) async {
    return await _authRepository.signup(params: params);
  }
}
