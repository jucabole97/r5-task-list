import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/domain/repositories/authentication_repository.dart';

class IsUserAuthenticatedUseCase {
  final AuthenticationRepository _authRepository;
  
  IsUserAuthenticatedUseCase({
    AuthenticationRepository? authRepository,
  }) : _authRepository = authRepository ?? locator<AuthenticationRepository>();

  bool call() {
    return _authRepository.isUserAuthenticated();
  }
}