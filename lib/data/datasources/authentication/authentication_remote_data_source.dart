import 'package:firebase_auth/firebase_auth.dart';
import 'package:r5_task_list/core/framework/text_utils.dart';
import 'package:r5_task_list/data/models/service_model.dart';

/// Abstract class for the Authentication remote data source.
abstract class AuthenticationRemoteDataSource {

  Future<Service> loginUser({ required String email, required String password });

  Future<void> signOut();
  
}

/// Implementation of the Authentication remote data source
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationRemoteDataSourceImpl();

  @override
  Future<Service> loginUser({ required String email, required String password }) async {
    try {
      final String encryptedPassword = TextUtils.encryptPassword(password);
      final List<String> providers = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      final UserCredential user;
      if (providers.isNotEmpty) {
        user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: encryptedPassword,
        );
      } else {
        user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: encryptedPassword,
        );
      }
      return Service(
        isOk: user.user != null,
        data: user,
      );
    } catch (e) {
      return Service(
        isOk: false,
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}