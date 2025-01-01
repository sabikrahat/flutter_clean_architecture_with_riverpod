import 'dart:convert';

import '../../domain/entities/user_entity.dart';

part 'user.ext.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userId,
    required super.createdAt,
    required super.fullName,
    required super.role,
    required super.location,
    required super.goals,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json[_Json.userId],
      createdAt: DateTime.parse(json[_Json.createdAt]),
      fullName: json[_Json.fullName],
      role: List<String>.from(json[_Json.role]),
      location: json[_Json.location],
      goals: List<String>.from(json[_Json.goals]),
    );
  }

  // from raw json
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  // from json list
  static List<UserModel> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => UserModel.fromJson(e)).toList();

  // to json list
  static List<Map<String, dynamic>> toJsonList(List<UserModel> list,
          [bool sendApi = false]) =>
      list.map((e) => e.toJson()).toList();

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}

class _Json {
  static const userId = 'user_id';
  static const createdAt = 'created_at';
  static const fullName = 'full_name';
  static const role = 'role';
  static const location = 'location';
  static const goals = 'goals';
}
