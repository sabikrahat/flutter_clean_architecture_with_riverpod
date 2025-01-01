import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../settings/presentation/view/setting_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(appName),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => await context.push(const SettingsView()),
        child: const Icon(Icons.settings_outlined),
      ),
    );
  }
}
