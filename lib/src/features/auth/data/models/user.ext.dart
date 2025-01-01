part of 'user.dart';

extension UserExtension on UserModel {
  // copy with
  UserModel copyWith({
    String? userId,
    DateTime? createdAt,
    String? fullName,
    List<String>? role,
    String? location,
    List<String>? goals,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      location: location ?? this.location,
      goals: goals ?? this.goals,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      _Json.userId: userId,
      _Json.createdAt: createdAt.toIso8601String(),
      _Json.fullName: fullName,
      _Json.role: role,
      _Json.location: location,
      _Json.goals: goals,
    };
  }

  // to raw json
  String toRawJson() => json.encode(toJson());
}