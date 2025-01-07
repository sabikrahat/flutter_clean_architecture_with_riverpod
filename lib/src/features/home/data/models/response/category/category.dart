import 'dart:convert';

import '../../../../domain/entity/category_entity.dart';

part 'category.ext.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
  });

  // from json
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json[_Json.id],
      name: json[_Json.name],
      image: json[_Json.image],
      createdAt: DateTime.parse(json[_Json.created]),
      updatedAt: DateTime.parse(json[_Json.updated]),
    );
  }

  // from raw json
  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  // from json list
  static List<CategoryModel> fromJsonList(
          List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => CategoryModel.fromJson(e)).toList();

  // to json list
  static List<Map<String, dynamic>> toJsonList(List<CategoryModel> list,
          [bool sendApi = false]) =>
      list.map((e) => e.toJson()).toList();

  // from entity factory
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const image = 'image';
  static const created = 'creationAt';
  static const updated = 'updatedAt';
}
