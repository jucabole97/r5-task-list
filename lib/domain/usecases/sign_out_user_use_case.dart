import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/domain/repositories/authentication_repository.dart';

class SignOutUserUseCase {
  final AuthenticationRepository _authRepository;
  
  SignOutUserUseCase({
    AuthenticationRepository? authRepository,
  }) : _authRepository = authRepository ?? locator<AuthenticationRepository>();

  Future<void> call() {
    return _authRepository.signOut();
  }
}