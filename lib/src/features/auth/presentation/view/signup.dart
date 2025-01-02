import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/config/size.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../providers/auth.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  static const name = 'signup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authProvider);
    final notifier = ref.watch(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Form(
              key: notifier.signupFormKey,
              child: Column(
                spacing: defaultPadding,
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    "Sign up",
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: notifier.emailController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) =>
                        v.isNullOrEmpty ? 'Name is required' : null,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onFieldSubmitted: (_) async =>
                        await notifier.signup(context),
                  ),
                  TextFormField(
                    controller: notifier.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) => v.isNullOrEmpty
                        ? 'Email is required'
                        : !v!.isEmail
                            ? 'Invalid email address'
                            : null,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onFieldSubmitted: (_) async =>
                        await notifier.signup(context),
                  ),
                  TextFormField(
                    controller: notifier.passwordController,
                    obscureText: notifier.obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(notifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: notifier.toggleObscureText,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    autofillHints: const [AutofillHints.password],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) =>
                        v.isNullOrEmpty ? 'Password is required' : null,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onFieldSubmitted: (_) async =>
                        await notifier.signup(context),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  ElevatedButton(
                    onPressed: notifier.isLoading
                        ? null
                        : () async => await notifier.signup(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: notifier.isLoading
                        ? SpinKitThreeBounce(
                            color: context.theme.primaryColor,
                            size: 20,
                          )
                        : const Text("Sign up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
