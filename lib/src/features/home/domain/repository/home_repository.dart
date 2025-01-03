import 'package:dartz/dartz.dart';
import '../entity/product_entity.dart';

abstract class HomeRepository {
  Future<Either<dynamic, List<ProductEntity>>> getProductData();
}
