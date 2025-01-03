import 'package:dartz/dartz.dart';
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
}
