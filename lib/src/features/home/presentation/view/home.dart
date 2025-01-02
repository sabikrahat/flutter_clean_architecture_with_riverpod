import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/features/home/presentation/provider/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/router/go_router.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeProvider);
    final notifier = ref.watch(homeProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('data: ${notifier.products.length}'),
            Expanded(
              child: ListView.builder(
                  itemCount: notifier.products.length,
                  itemBuilder: (context, index) {
                    final product = notifier.products[index];
                    return ListTile(
                      title: Text('Title: ${product.title}'),
                      subtitle: Text('Price: ${product.price}'),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => await context.goPush(AppRoutes.settingsRoute),
        child: const Icon(Icons.settings_outlined),
      ),
    );
  }
}
