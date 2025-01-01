import 'dart:convert';

import '../../../domain/entities/user_entity.dart';

part 'user.ext.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.created,
    required super.updated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[_Json.id],
      email: json[_Json.email],
      name: json[_Json.name],
      created: DateTime.parse(json[_Json.created]),
      updated: DateTime.parse(json[_Json.updated]),
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
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const email = 'email';
  static const name = 'name';
  static const created = 'created';
  static const updated = 'updated';
}
