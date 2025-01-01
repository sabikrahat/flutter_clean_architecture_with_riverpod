import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/config/size.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/extensions/extensions.dart';
import 'package:flutter_clean_architecture_template/src/features/auth/presentation/providers/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/config/constants.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authProvider);
    final notifier = ref.watch(authProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Form(
              key: notifier.formKey,
              child: Column(
                spacing: defaultPadding,
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    "Sign in",
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding),
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
                    onFieldSubmitted: (_) async =>
                        await notifier.submit(context),
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
                    onFieldSubmitted: (_) async =>
                        await notifier.submit(context),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  ElevatedButton(
                    onPressed: notifier.isLoading
                        ? null
                        : () async => await notifier.submit(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: notifier.isLoading
                        ? SpinKitThreeBounce(
                            color: context.theme.primaryColor,
                            size: 20,
                          )
                        : const Text("Sign in"),
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
