import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  static String get fileName => '.env';

  static String get devBaseUrl => dotenv.env['DEV_BASE_URL'] ?? 'Dev Base URL Not Found';

  static String get prodBaseUrl => dotenv.env['PROD_BASE_URL'] ?? 'Prod Base URL Not Found';

  static String get devAnonKey => dotenv.env['DEV_ANON_KEY'] ?? 'Dev Anon Key Not Found';

  static String get prodAnonKey => dotenv.env['PROD_ANON_KEY'] ?? 'Prod Anon Key Not Found';
}
