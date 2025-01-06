import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/features/home/data/models/request/add_product.dart';
import '../../../../../core/api_client/api_client.dart';
import '../../../../../core/api_client/enum/method.dart';
import '../../models/response/product/product.dart';
import '../../../domain/entity/product_entity.dart';

abstract class HomeRemoteService {
  Future<Either> getProductData();
  Future<Either> addProduct({required AddProductParams addProductParams});
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

  
  @override
  Future<Either> addProduct({required AddProductParams addProductParams}) async{
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'products',
        data: addProductParams.toJson(),
        isAuthRequired: false,
      );

      return Right(response);

    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      return Left(e);
    }
  }
}