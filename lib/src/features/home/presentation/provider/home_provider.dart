import 'package:flutter_clean_architecture_template/src/features/home/domain/entity/product_entity.dart';
import 'package:flutter_clean_architecture_template/src/features/home/domain/use_case/get_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injector.dart';

typedef HomeNotifier = NotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends Notifier {
  bool isLoading = false;

  @override
  void build() {
    getProductData();
  }

  List<ProductEntity> products = [];

  Future<void> getProductData() async {
    isLoading = true;
    ref.notifyListeners();
    final response = await sl<GetProductUseCase>().call();
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
      },
      (success) async {
        isLoading = false;
        products = [...success];
        ref.notifyListeners();
      },
    );
  }
}
