import 'package:r5_task_list/core/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class for the Authentication local data source.
abstract class AuthenticationLocalDataSource {
  /// Method to get email to user in local data
  String? get currentUser;

  /// Method to save email to user in local data
  Future<void> setCurrentUser(String uid);

  ///Method to delete a user in local data
  void deleteUser();
}

/// Implementation of the AuthenticationLocalDataSource
class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final SharedPreferences _sharedPreferencesManager;

  AuthenticationLocalDataSourceImpl({
    SharedPreferences? sharedPreferencesManager
  }) : _sharedPreferencesManager = sharedPreferencesManager ?? sharedPreferences;
  
  @override
  void deleteUser() {
    _sharedPreferencesManager.remove('uid');
  }
  
  @override
  String? get currentUser => _sharedPreferencesManager.getString('uid');
  
  @override
  Future<void> setCurrentUser(String uid) async {
    await _sharedPreferencesManager.setString('uid', uid);
  }
}