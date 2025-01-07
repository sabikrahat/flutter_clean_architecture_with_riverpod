import 'package:dartz/dartz.dart';
import '../../data/models/request/add_product.dart';
import '../repository/home_repository.dart';

class AddProductUseCase {
  final HomeRepository _repository;

  AddProductUseCase(this._repository);

  Future<Either> call({required AddProductParams addProductParams}) async {
    return _repository.addProduct(addProductParams: addProductParams);
  }

}
