part of 'product.dart';

extension ProductExtension on ProductModel {
  // copy with
  ProductModel copyWith({
   int? id,
   String? title,
   double? price,
   String? description,
   List<String>? images,
   DateTime? createdAt,
   DateTime? updatedAt,
   CategoryModel? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.title: title,
      _Json.price: price,
      _Json.description: description,
      _Json.category: CategoryModel.fromEntity(category).toJson(),
      _Json.images: images,
      _Json.createdAt: createdAt.toIso8601String(),
      _Json.updatedAt: updatedAt.toIso8601String(),
    };
  }

  // to raw json
  String toRawJson() => json.encode(toJson());
}
