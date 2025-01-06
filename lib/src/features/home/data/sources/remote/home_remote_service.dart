import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../../core/api_client/api_client.dart';
import '../../../../../core/api_client/enum/method.dart';
import '../../models/response/product/product.dart';
import '../../../domain/entity/product_entity.dart';

abstract class HomeRemoteService {
  Future<Either> getProductData();
}

class HomeRemoteServiceImpl extends HomeRemoteService {
  final ApiClient _apiClient;

  HomeRemoteServiceImpl(this._apiClient);

  @override
  Future<Either<dynamic, List<ProductEntity>>> getProductData() async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.get,
        'products',
        isAuthRequired: false,
      );

      final List<dynamic> apiResponse = json.decode(response);

      // return Right(ProductModel.fromJsonList(apiResponse));

      return Right(apiResponse.map((e) => ProductModel.fromJson(e)).toList());
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }
}
