import 'package:dartz/dartz.dart';
import '../../data/model/request/auth_request/login_request.dart';
import '../../data/model/request/auth_request/register_request.dart';
import '../../data/repositorys/auth_repository/repository/auth_repsitory_imp.dart';
import '../repository/repository/auth_repository_contract.dart';

import '../entities/auth_response_entities.dart';
import '../../helper/failuers/failures.dart';

class LoginUseCasese {
  AuthRepositoryContract authRepositoryContract;
  LoginUseCasese({required this.authRepositoryContract});
  Future<Either<Failuer, AuthResponseEntity?>> inVoik(
      LoginRequest loginRequest) {
    return authRepositoryContract.login(loginRequest);
  }
}

LoginUseCasese injcectLoginUseCasese() {
  return LoginUseCasese(authRepositoryContract: injectAuthRepositoryContract());
}
