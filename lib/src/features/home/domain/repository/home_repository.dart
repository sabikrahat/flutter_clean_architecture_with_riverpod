import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/features/home/domain/entity/product_entity.dart';

abstract class HomeRepository {
  Future<Either<dynamic, List<ProductEntity>>> getProductData();
}
