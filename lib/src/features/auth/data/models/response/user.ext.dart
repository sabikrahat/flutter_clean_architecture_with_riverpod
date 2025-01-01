part of 'user.dart';

extension UserExtension on UserModel {
  // copy with
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? created,
    DateTime? updated,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.email: email,
      _Json.name: name,
      _Json.created: created.toIso8601String(),
      _Json.updated: updated.toIso8601String(),
    };
  }

  // to raw json
  String toRawJson() => json.encode(toJson());
}
