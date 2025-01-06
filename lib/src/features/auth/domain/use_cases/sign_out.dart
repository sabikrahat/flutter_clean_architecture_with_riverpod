import 'package:dartz/dartz.dart';

import '../repository/auth_repository.dart';

class SignoutUseCase {
  final AuthRepository _authRepository;

  SignoutUseCase(this._authRepository);

  Future<Either> call() async {
    return await _authRepository.signout();
  }
}
