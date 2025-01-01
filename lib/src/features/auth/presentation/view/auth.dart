import 'package:flutter/material.dart';
import '../../../../core/config/size.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../providers/auth.dart';
import 'signup.dart';
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
              key: notifier.signinFormKey,
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    "Sign in",
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding * 3),
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
                        await notifier.signin(context),
                  ),
                  const SizedBox(height: defaultPadding),
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
                        await notifier.signin(context),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password?",
                        style: context.text.bodyMedium?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  ElevatedButton(
                    onPressed: notifier.isLoading
                        ? null
                        : () async => await notifier.signin(context),
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
                  const SizedBox(height: defaultPadding),
                  TextButton(
                    onPressed: () async =>
                        await context.push(const SignupView()),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: " Sign Up",
                            style: context.text.bodyMedium?.copyWith(
                              color: context.theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      style: context.text.bodyMedium,
                    ),
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
