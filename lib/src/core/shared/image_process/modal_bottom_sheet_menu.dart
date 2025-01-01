import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/extensions/extensions.dart';
import '../../utils/logger/logger_helper.dart';
import 'take_image_option.dart';

Future<XFile?> modalBottomSheetMenu(
  BuildContext context, {
  bool isCircle = false,
  List<CropAspectRatioPreset>? aspectRatioPresets,
  int imageQuality = 100,
  List<String>? allowedExtensions,
}) async {
  return showModalBottomSheet(
    elevation: 2.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    context: context,
    builder: (_) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            'Choose an Option',
            style: context.theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text('Capture Image With Camera'),
          onTap: () async {
            // Checking Permission
            final status = await Permission.camera.status;
            log.i('Camera Permission Status: $status');
            if (!status.isGranted) {
              log.i('Requesting Camera Permission');
              await Permission.camera.request();
              return;
            }
            //
            if (!context.mounted) return;
            await takeImageOption(
              context,
              ImageSource.camera,
              isCircle: isCircle,
              aspectRatioPresets: aspectRatioPresets,
              imageQuality: imageQuality,
              allowedExtensions: allowedExtensions,
            ).then((file) async {
              if (file == null) return;
              if (!context.mounted) return;
              context.pop(file);
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Select Image From Gallery'),
          onTap: () async {
            // Checking Permission
            final status = await Permission.photos.status;
            log.i('Gallery Permission Status: $status');
            if (status.isPermanentlyDenied) {
              log.i('Permission Denied permanently. Showing error popup!');
              EasyLoading.showError('Permission Denied permanently');
              await Permission.photos.request();
              return;
            }
            if (!status.isGranted) {
              log.i('Requesting Gallery Permission');
              await Permission.photos.request();
              return;
            }
            //
            if (!context.mounted) return;
            await takeImageOption(
              context,
              ImageSource.gallery,
              isCircle: isCircle,
              aspectRatioPresets: aspectRatioPresets,
              imageQuality: imageQuality,
              allowedExtensions: allowedExtensions,
            ).then((file) async {
              if (file == null) return;
              if (!context.mounted) return;
              context.pop(file);
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.cancel),
          title: const Text('Cancel'),
          onTap: () => context.pop(null),
        ),
      ],
    ),
  );
}
