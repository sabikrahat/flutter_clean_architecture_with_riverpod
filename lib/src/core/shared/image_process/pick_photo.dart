import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../injector.dart';
import '../../config/get_platform.dart';
import 'modal_bottom_sheet_menu.dart';

Future<XFile?> pickPhoto(
  BuildContext context, {
  bool isCircle = false,
  int imageQuality = 60,
  List<String>? allowedExtensions,
}) async {
  if (sl<PT>().isNotMobile) return null;
  return await modalBottomSheetMenu(
    context,
    isCircle: isCircle,
    aspectRatioPresets: [CropAspectRatioPreset.square],
    imageQuality: imageQuality,
    allowedExtensions: allowedExtensions,
  );
}
