import 'package:flutter/material.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../core/shared/riverpod/helper.dart';
import '../../../domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/product.dart';

class ProductView extends ConsumerWidget {
  const ProductView({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(productProvider(product)).when(
        loading: riverpodLoading,
        error: riverpodError,
        data: (_) {
          final notifier = ref.read(productProvider(product).notifier);
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: mainCenter,
                spacing: 10,
                children: [
                  Text(notifier.product.title),
                  Text(notifier.product.price.toString()),
                  Text(notifier.product.description),
                  Text(notifier.product.category.id.toString()),
                  Text(notifier.product.images.first),
                ],
              ),
            ),
          );
        });
  }
}
