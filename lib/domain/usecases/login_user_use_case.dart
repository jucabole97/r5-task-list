import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/models/service_model.dart';
import 'package:r5_task_list/domain/repositories/authentication_repository.dart';

class LoginUserUseCase {
  final AuthenticationRepository _authRepository;
  
  LoginUserUseCase({
    AuthenticationRepository? authRepository,
  }) : _authRepository = authRepository ?? locator<AuthenticationRepository>();

  Future<Service> call({ required String email, required String password }) {
    return _authRepository.loginUser(email: email, password: password);
  }
}