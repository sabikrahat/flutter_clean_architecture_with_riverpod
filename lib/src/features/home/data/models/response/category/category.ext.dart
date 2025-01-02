part of 'category.dart';

extension CategoryExtension on CategoryModel {
  // copy with
  CategoryModel copyWith({
    int? id,
    String? name,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: createdAt ?? this.updatedAt,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.name: name,
      _Json.image: image,
      _Json.created: createdAt.toIso8601String(),
      _Json.updated: updatedAt.toIso8601String(),
    };
  }

  // to raw json
  String toRawJson() => json.encode(toJson());
}
