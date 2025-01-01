import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/shared/animations_widget/animated_popup.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../localization/loalization.dart';
import '../../providers/time_format_provider.dart';

class TimeFormatTile extends StatelessWidget {
  const TimeFormatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SvgPicture.asset(
            'assets/svgs/time-format.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Time Format',
          ),
        ),
      ),
      title: Text(
        t.timeFormat,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(minimumSize: const Size(50, 48)),
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const TimeFormatChangerPopup(),
          );
        },
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: Consumer(
          builder: (_, ref, __) {
            final timeFormat = ref.watch(timeFormatProvider);
            return Text(
              DateFormat(timeFormat).format(DateTime.now()),
              style:
                  context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
            );
          },
        ),
      ),
    );
  }
}

class TimeFormatChangerPopup extends ConsumerWidget {
  const TimeFormatChangerPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Time Format'),
            const Spacer(),
            const SizedBox(width: 10.0),
            InkWell(
              customBorder: roundedRectangleBorder30,
              child: const Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                timeFormates.length,
                (index) => KListTile(
                  onTap: () async => await ref
                      .read(timeFormatProvider.notifier)
                      .changeTimeFormat(timeFormates[index])
                      .then((_) {
                    if (!context.mounted) return;
                    context.pop();
                  }),
                  leading: Radio<String?>(
                    value: timeFormates[index],
                    groupValue: ref.watch(timeFormatProvider),
                    onChanged: (v) async => await ref
                        .read(timeFormatProvider.notifier)
                        .changeTimeFormat(v!)
                        .then((_) {
                      if (!context.mounted) return;
                      context.pop();
                    }),
                  ),
                  title: Text(
                    DateFormat(timeFormates[index]).format(DateTime.now()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
