import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../localization/loalization.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/shared/animations_widget/animated_widget_shower.dart';
import '../../../../../core/shared/k_list_tile.dart/k_list_tile.dart';
import '../../providers/performance_overlay_provider.dart';

class PerformanceOverlayTile extends StatelessWidget {
  const PerformanceOverlayTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/performance-overlay.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Performance Overlay',
        ),
      ),
      title: Text(
        t.performanceOverlay,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Transform.scale(
        scale: 0.7,
        child: Consumer(
          builder: (_, ref, __) => CupertinoSwitch(
            value: ref.watch(performanceOverlayProvider),
            onChanged: (v) async => await ref
                .read(performanceOverlayProvider.notifier)
                .changePerformanceOverlay(v),
          ),
        ),
      ),
    );
  }
}
