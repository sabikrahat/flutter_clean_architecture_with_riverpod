import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/features/home/domain/entity/product_entity.dart';
import 'package:flutter_clean_architecture_template/src/features/home/domain/repository/home_repository.dart';

class GetProductUseCase {
  final HomeRepository _repository;

  GetProductUseCase(this._repository);

  Future<Either<dynamic, List<ProductEntity>>> call() async {
    return _repository.getProductData();
  }
}
