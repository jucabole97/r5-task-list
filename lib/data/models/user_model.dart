import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? email;
  final String? uid;

  UserModel({
    this.email,
    this.uid,
  });

  bool get isUserAuthenticated => uid != null;

  UserModel copyWith({ String? email, String? uid }) {
    return UserModel(
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

  factory UserModel.fromUser(User? user) {
    return UserModel(
      email: user?.email,
      uid: user?.uid,
    );
  }
}

class AnonymousUser extends UserModel {
  AnonymousUser();
}