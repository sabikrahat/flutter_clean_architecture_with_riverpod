import 'dart:convert';

import 'package:hive_ce/hive.dart';

import '../../../features/settings/data/repositories/hive_box.dart';
import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

part 'auth_store.ext.dart';
part 'auth_store.g.dart';

@HiveType(typeId: HiveTypes.authStores)
class AuthStore extends HiveObject {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String accessToken;
  @HiveField(2)
  String refreshToken;

  AuthStore({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthStore.fromJson(Map<String, dynamic> json) => AuthStore(
        userId: json[_Json.userId] as String,
        accessToken: json[_Json.accessToken] as String,
        refreshToken: json[_Json.refreshToken] as String,
      );

  factory AuthStore.fromRawJson(String source) =>
      AuthStore.fromJson(json.decode(source));

  Map<String, dynamic> toJson() => {
        _Json.userId: userId,
        _Json.accessToken: accessToken,
        _Json.refreshToken: refreshToken,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => toRawJson();

  bool get isAccessTokenValid => _isValid(accessToken);
  bool get isRefreshTokenValid => _isValid(refreshToken);

  bool _isValid(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    final tokenPart = base64.normalize(parts[1]);
    final data = jsonDecode(utf8.decode(base64Decode(tokenPart)))
        as Map<String, dynamic>;

    final exp = data['exp'] is int
        ? data['exp'] as int
        : (int.tryParse(data['exp'].toString()) ?? 0);

    return exp > (DateTime.now().millisecondsSinceEpoch / 1000);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthStore && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}

class _Json {
  static const userId = 'user_id';
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}
