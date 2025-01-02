import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/shared/animations_widget/animated_popup.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../localization/loalization.dart';
import '../../../../auth/presentation/providers/auth.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/svgs/signout.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Signout',
          ),
        ),
      ),
      title: Text(
        t.signout,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SignoutPopup(),
      ),
    );
  }
}

class SignoutPopup extends ConsumerWidget {
  const SignoutPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: context.theme.dividerColor.withValues(alpha: 0.8)),
            ),
          ),
          TextButton(
            onPressed: () async =>
                await ref.read(authProvider.notifier).signout(context),
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
