import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/shared/animations_widget/animated_popup.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../localization/loalization.dart';
import '../../providers/url_config_provider.dart';

class URLConfigTile extends StatelessWidget {
  const URLConfigTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/url-config.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Url Config',
        ),
      ),
      title: Text(
        t.urlConfig,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const URLConfigPopup(),
      ),
    );
  }
}

class URLConfigPopup extends ConsumerWidget {
  const URLConfigPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(urlConfigProvider);
    final notifier = ref.watch(urlConfigProvider.notifier);
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        actionsPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        title: const Text('URL Config'),
        content: SizedBox(
          width: min(280, context.width),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ToggleButtons(
                borderRadius: BorderRadius.circular(25.0),
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 36.0),
                isSelected: List.generate(
                  notifier.headers.length,
                  (i) => notifier.currUrlIndex == i,
                ),
                selectedColor: context.theme.primaryColor,
                onPressed: notifier.toggleUrl,
                children: List.generate(
                  notifier.headers.length,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      notifier.headers[i],
                      style: TextStyle(
                        color: notifier.currUrlIndex == i
                            ? context.theme.primaryColor
                            : context.theme.dividerColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                enabled: false,
                controller: notifier.baseUrlCntrlr,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 10.0),
                  labelText: 'Base URL',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                enabled: false,
                controller: notifier.anonKeyCntrlr,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 10.0),
                  labelText: 'Anon Key',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: context.theme.dividerColor.withValues(alpha: 0.8)),
            ),
          ),
          TextButton(
            child: Text('Done',
                style: TextStyle(color: context.theme.primaryColor)),
            onPressed: () async => await notifier.submit().then((_) {
              if (!context.mounted) return;
              context.pop();
            }),
          ),
        ],
      ),
    );
  }
}