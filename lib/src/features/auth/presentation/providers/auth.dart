import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/entry_point.dart';

typedef AuthNotifier = NotifierProvider<AuthProvider, void>;

final authProvider = AuthNotifier(AuthProvider.new);

class AuthProvider extends Notifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  @override
  void build() {
    emailController.text = 'sabikrahat72428@gmail.com';
    passwordController.text = '@Rahat123';
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading = true;
    ref.notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    isLoading = false;
    ref.notifyListeners();
    if (!context.mounted) return;
    await context.push(const EnteryPoint());
  }
}
