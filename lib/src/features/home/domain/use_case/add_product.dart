import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/features/home/data/models/request/add_product.dart';
import 'package:flutter_clean_architecture_template/src/features/home/domain/repository/home_repository.dart';

class AddProductUseCase {
  final HomeRepository _repository;

  AddProductUseCase(this._repository);

  Future<Either> call({required AddProductParams addProductParams}) async {
    return _repository.addProduct(addProductParams: addProductParams);
  }

}
