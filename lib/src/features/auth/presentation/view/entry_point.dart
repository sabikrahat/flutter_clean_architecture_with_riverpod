import 'package:flutter/material.dart';
import '../../../../core/api_client/api_client.dart';

import '../../../../injector.dart';
import '../../../home/presentation/view/home.dart';
import 'auth.dart';

class EnteryPoint extends StatelessWidget {
  const EnteryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return sl<ApiClient>().authStore == null
        ? const AuthView()
        : const HomeView();
  }
}
