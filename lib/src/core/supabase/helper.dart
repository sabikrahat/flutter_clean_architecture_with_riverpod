import '../../features/settings/data/models/settings_model.dart';
import '../../injector.dart';
import '../config/environment.dart';

String get storageUrl =>
    '${sl<AppSettings>().isProduction ? Environment.prodBaseUrl : Environment.devBaseUrl}/storage/v1/object';

///
/// Collections name
///
const usersTbl = 'users';

///
/// Buckets name
///
const avatarsBkt = 'avatars';
