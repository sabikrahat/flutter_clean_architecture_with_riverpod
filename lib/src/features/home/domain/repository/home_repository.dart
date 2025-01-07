import 'package:dartz/dartz.dart';
import '../../data/models/request/add_product.dart';
import '../entity/product_entity.dart';

abstract class HomeRepository {
  Future<Either<dynamic, List<ProductEntity>>> getProductData();
  Future<Either> addProduct({required AddProductParams addProductParams});
}
