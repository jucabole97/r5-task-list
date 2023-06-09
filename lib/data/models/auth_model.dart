class Auth {
  final String? email;
  final String? password;

  Auth({
    this.email,
    this.password,
  });

  Auth copyWith({ String? email, String? password }) {
    return Auth(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}