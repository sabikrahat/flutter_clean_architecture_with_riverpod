class SignupParams {
  final String name;
  final String email;
  final String password;
  final DateTime created;
  final DateTime updated;

  SignupParams({
    required this.name,
    required this.email,
    required this.password,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toJson() {
    return {
      _Json.name: name,
      _Json.email: email,
      _Json.password: password,
      _Json.created: created.toUtc().toIso8601String(),
      _Json.updated: updated.toUtc().toIso8601String(),
    };
  }
}

class _Json {
  static const name = 'name';
  static const email = 'email';
  static const password = 'password';
  static const created = 'created';
  static const updated = 'updated';
}
