class AddProductParams {
  final String title;
  final double price;
  final String description;
  final int categoryId;
  final List<String> images;

AddProductParams({
    required this.title,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      _Json.title: title,
      _Json.price: price,
      _Json.description: description,
      _Json.categoryId: categoryId,
      _Json.images: images,

    };
  }
}

class _Json {
  static const title = 'title';
  static const price = 'price';
  static const description = 'description';
  static const categoryId = 'categoryId';
  static const images = 'images';
}