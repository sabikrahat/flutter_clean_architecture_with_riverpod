import 'dart:async';

import '../../domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ProductNotifier
    = AsyncNotifierProviderFamily<ProductProvider, void, ProductEntity>;

final productProvider = ProductNotifier(ProductProvider.new);

class ProductProvider extends FamilyAsyncNotifier<void, ProductEntity> {
  late ProductEntity _product;

  ProductEntity get product => _product;

  @override
  FutureOr<void> build(ProductEntity arg) async {
    await Future.delayed(const Duration(seconds: 1));
    _product = arg;
  }
}
