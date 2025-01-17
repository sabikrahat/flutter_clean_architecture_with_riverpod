import 'package:flutter_riverpod/flutter_riverpod.dart';

// typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, List<ProductEntity>>;

final homeProvider = NotifierProvider<HomeProvider, void>(HomeProvider.new);

class HomeProvider extends Notifier<void> {
  @override
  build() {}
}
