import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/features/home/presentation/view/widgets/create_product_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/size.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/router/go_router.dart';
import '../../../../core/shared/riverpod/helper.dart';
import '../provider/home_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(homeProvider).when(
          loading: riverpodLoading,
          error: riverpodError,
          data: (_) {
            final notifier = ref.watch(homeProvider.notifier);
            return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () async =>
                        await context.goPush(AppRoutes.settingsRoute),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton.small(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => NewProductDialog(),
                ),
                child: Text(
                  notifier.products.length.toString(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: RefreshIndicator(
                  onRefresh: notifier.refresh,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: notifier.products.length,
                    itemBuilder: (context, index) {
                      final product = notifier.products[index];
                      return ListTile(
                        onTap: () => context.goPush(
                          AppRoutes.productRoute,
                          extra: product,
                        ),
                        title: Text('Title: ${product.title}'),
                        subtitle: Text('Price: ${product.price}'),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
  }
}
