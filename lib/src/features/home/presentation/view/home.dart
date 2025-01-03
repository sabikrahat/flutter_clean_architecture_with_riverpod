import 'package:flutter/material.dart';
import '../../../../core/config/size.dart';
import '../provider/home_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/router/go_router.dart';
import '../../../../core/shared/riverpod/helper.dart';

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
                onPressed: () => EasyLoading.showToast(
                  'Will update soon',
                  toastPosition: EasyLoadingToastPosition.bottom,
                ),
                child: Text(notifier.products.length.toString()),
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
