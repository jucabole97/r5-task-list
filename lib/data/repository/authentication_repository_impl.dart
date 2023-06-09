import 'package:firebase_auth/firebase_auth.dart';
import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/datasources/authentication/authentication_local_data_source.dart';
import 'package:r5_task_list/data/datasources/authentication/authentication_remote_data_source.dart';
import 'package:r5_task_list/data/models/service_model.dart';
import 'package:r5_task_list/data/models/user_model.dart';
import 'package:r5_task_list/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource _localDataSource;
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl({
    AuthenticationLocalDataSource? localDataSource,
    AuthenticationRemoteDataSource? remoteDataSource,
  }) : _localDataSource = localDataSource ?? locator<AuthenticationLocalDataSource>(),
        _remoteDataSource = remoteDataSource ?? locator<AuthenticationRemoteDataSource>();
  
  @override
  Future<Service> loginUser({ required String email, required String password }) async {
    final Service response = await _remoteDataSource.loginUser(
      email: email,
      password: password,
    );
    if ((response.isOk ?? false) && response.data?.user != null) {
      final UserModel user = UserModel.fromUser(response.data?.user as User);
      if (user.isUserAuthenticated) {
        await _localDataSource.setCurrentUser(user.uid!);
      }
    }
    return response;
  }

  @override
  bool isUserAuthenticated() {
    return _localDataSource.currentUser != null;
  }
  
  @override
  Future<void> signOut() {
    _localDataSource.deleteUser();
    return _remoteDataSource.signOut();
  }
}