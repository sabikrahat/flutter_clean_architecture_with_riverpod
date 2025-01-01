import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ksnackbar/ksnackbar.dart';

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text)).then((_) {
    if (!context.mounted) return;
    return KSnackbar.show(context, 'Copied to clipboard! [$text]', second: 1);
  });
}

Future<String> getCliboardData() async {
  final data = await Clipboard.getData(Clipboard.kTextPlain);
  return data?.text ?? '';
}
