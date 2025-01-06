import 'package:dartz/dartz.dart';
import '../entity/product_entity.dart';
import '../repository/home_repository.dart';

class GetProductUseCase {
  final HomeRepository _repository;

  GetProductUseCase(this._repository);

  Future<Either<dynamic, List<ProductEntity>>> call() async {
    return _repository.getProductData();
  }
}
