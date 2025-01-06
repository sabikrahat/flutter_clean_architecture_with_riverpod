import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/features/home/presentation/provider/add_product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewProductDialog extends ConsumerWidget {
  const NewProductDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addProductProvider);
    final notifier = ref.watch(addProductProvider.notifier);
    return AlertDialog(
      title: Text('New Product'),
      content: SingleChildScrollView(
        child: Form(
          key: notifier.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              TextFormField(
                controller: notifier.titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: notifier.priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: notifier.descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: notifier.categoryIdController,
                decoration: InputDecoration(labelText: 'Category ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: notifier.imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            notifier.submit(context);
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
