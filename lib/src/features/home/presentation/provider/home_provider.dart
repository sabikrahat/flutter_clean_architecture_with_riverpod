import 'dart:async';

import '../../domain/entity/product_entity.dart';
import '../../domain/use_case/get_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injector.dart';

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, List<ProductEntity>>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<List<ProductEntity>> {
  bool isLoading = false;

  late List<ProductEntity> _products;

  @override
  FutureOr<List<ProductEntity>> build() async {
    _products = [];
    final response = await sl<GetProductUseCase>().call();
    response.fold(
      (error) => throw error,
      (success) => _products = success,
    );
    return _products;
  }

  List<ProductEntity> get products => _products;

  Future<void> refresh() async {
    isLoading = true;
    ref.notifyListeners();
    //
    final response = await sl<GetProductUseCase>().call();
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
        throw error;
      },
      (success) {
        _products = success;
        isLoading = false;
        ref.notifyListeners();
      },
    );
  }
}
