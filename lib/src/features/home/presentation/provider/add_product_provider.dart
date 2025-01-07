import 'package:flutter/material.dart';
import '../../../../core/shared/ksnackbar/ksnackbar.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/models/request/add_product.dart';
import '../../data/models/response/product/product.dart';
import '../../domain/use_case/add_product.dart';
import 'home_provider.dart';
import '../../../../injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addProductProvider =
    NotifierProvider<AddProductProvider, void>(AddProductProvider.new);

class AddProductProvider extends Notifier<void> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  bool isLoading = false;

  @override
  build() {}

  Future<void> submit(BuildContext context) async {
    isLoading = true;
    ref.notifyListeners();

    if (formKey.currentState!.validate()) {
      final response = await sl<AddProductUseCase>().call(
          addProductParams: AddProductParams(
        title: titleController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        categoryId: int.parse(categoryIdController.text),
        images: [imageUrlController.text],
      ));

      response.fold(
        (error) {
          isLoading = false;
          ref.notifyListeners();
          KSnackbar.show(context, error.toString(), isError: true);
        },
        (success) async {
          isLoading = false;
          ref.notifyListeners();
          ref
              .read(homeProvider.notifier)
              .addProduct(ProductModel.fromRawJson(success));
          KSnackbar.show(context, 'Product added successfully');
          context.pop();
        },
      );
    }
  }
}
