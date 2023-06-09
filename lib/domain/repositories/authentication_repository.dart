import 'package:r5_task_list/data/models/service_model.dart';

abstract class AuthenticationRepository {
  ///Method to login user
  Future<Service> loginUser({ required String email, required String password });

  ///Method to sign out user
  Future<void> signOut();

  bool isUserAuthenticated();
}