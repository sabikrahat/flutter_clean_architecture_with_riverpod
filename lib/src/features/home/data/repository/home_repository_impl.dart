import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/features/home/data/models/request/add_product.dart';
import '../sources/remote/home_remote_service.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteService _homeRemoteService;

  HomeRepositoryImpl(this._homeRemoteService);
  @override
  Future<Either<dynamic, List<ProductEntity>>> getProductData() async {
    final response = await _homeRemoteService.getProductData();
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
  
  @override
  Future<Either> addProduct({required AddProductParams addProductParams}) async{
    final response = await _homeRemoteService.addProduct(addProductParams: addProductParams);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
