import 'package:flutter/material.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/router/go_router.dart';

import '../../../../core/config/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(appName),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => await context.goPush(AppRoutes.settingsRoute),
        child: const Icon(Icons.settings_outlined),
      ),
    );
  }
}
