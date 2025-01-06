import 'package:flutter/material.dart';
import '../../../../core/router/go_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared/ksnackbar/ksnackbar.dart';
import '../../../../injector.dart';
import '../../data/models/request/signin.dart';
import '../../data/models/request/signup.dart';
import '../../domain/use_cases/sign_out.dart';
import '../../domain/use_cases/signin.dart';
import '../../domain/use_cases/signup.dart';

typedef AuthNotifier = NotifierProvider<AuthProvider, void>;

final authProvider = AuthNotifier(AuthProvider.new);

class AuthProvider extends Notifier {
  final signinFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  @override
  void build() {
    nameController.text = 'John Doe';
    emailController.text = 'john@mail.com';
    passwordController.text = 'changeme';
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    ref.notifyListeners();
  }

  

  Future<void> signin(BuildContext context) async {
    if (!(signinFormKey.currentState?.validate() ?? false)) return;
    isLoading = true;
    ref.notifyListeners();
    //
    final response = await sl<SigninUseCase>().call(
      SigninParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
        KSnackbar.show(context, error.toString(), isError: true);
      },
      (success) async {
        isLoading = false;
        ref.notifyListeners();
        goRouter.refresh();
      },
    );
  }

  Future<void> signup(BuildContext context) async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;
    isLoading = true;
    ref.notifyListeners();
    //
    final response = await sl<SignupUseCase>().call(
      SignupParams(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
        KSnackbar.show(context, error.toString(), isError: true);
      },
      (success) async {
        isLoading = false;
        ref.notifyListeners();
        goRouter.refresh();
      },
    );
  }

  Future<void> forgetPassword(BuildContext context) async {
    KSnackbar.show(context, 'Will update soon');
    return;
  }

  Future<void> signout(BuildContext context) async {
    EasyLoading.show();
    final response = await sl<SignoutUseCase>().call();
    EasyLoading.dismiss();
    response.fold(
      (error) => KSnackbar.show(context, error.toString(), isError: true),
      (success) async {
        goRouter.refresh();
      },
    );
  }
}
