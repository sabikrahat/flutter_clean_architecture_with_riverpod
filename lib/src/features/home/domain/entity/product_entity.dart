import 'category_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryEntity category;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });
}
