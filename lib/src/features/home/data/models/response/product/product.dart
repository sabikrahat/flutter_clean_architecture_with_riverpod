import 'dart:convert';

import '../../../../domain/entity/product_entity.dart';
import '../category/category.dart';

part 'product.ext.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.images,
    required super.createdAt,
    required super.updatedAt,
    required super.category,
  });

  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[_Json.id],
      title: json[_Json.title],
      price: json[_Json.price],
      description: json[_Json.description],
      category: CategoryModel.fromJson(json[_Json.category]),
      images: List<String>.from(json[_Json.images]),
      createdAt: DateTime.parse(json[_Json.createdAt]),
      updatedAt: DateTime.parse(json[_Json.updatedAt]),
    );
  }

  // from raw json
  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  // from json list
  static List<ProductModel> fromJsonList(List<Map<String, dynamic>> jsonList) =>
      jsonList.map((e) => ProductModel.fromJson(e)).toList();

  // to json list
  static List<Map<String, dynamic>> toJsonList(List<ProductModel> list,
          [bool sendApi = false]) =>
      list.map((e) => e.toJson()).toList();

  // from entity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      images: entity.images,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      category: CategoryModel.fromEntity(entity.category),
    );
  }

  // to raw json
  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const title = 'title';
  static const price = 'price';
  static const images = 'images';
  static const category = 'category';
  static const description = 'description';
  static const createdAt = 'creationAt';
  static const updatedAt = 'updatedAt';
}
