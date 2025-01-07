import 'dart:async';

import 'package:flutter_clean_architecture_template/src/features/home/data/models/response/product/product.dart';
import 'package:flutter_clean_architecture_template/src/features/home/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ProductNotifier
    = AsyncNotifierProviderFamily<ProductProvider, void, ProductEntity>;

final productProvider = ProductNotifier(ProductProvider.new);

class ProductProvider extends FamilyAsyncNotifier<void, ProductEntity> {
  late ProductEntity _product;

  ProductEntity get product => _product;

  @override
  FutureOr<void> build(ProductEntity arg) async {
    await Future.delayed(const Duration(seconds: 2));
    _product = ProductModel.fromEntity(arg)
        .copyWith(description: 'Description from provider ${arg.id}');
  }
}
