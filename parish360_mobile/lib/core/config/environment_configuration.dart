import 'package:parish360_mobile/core/config/application_environment.dart';
import 'package:parish360_mobile/core/config/environment.dart';

class EnvironmentConfiguration {
  static late Environment instance;

  static void init(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.dev:
        instance = const Environment(
          environment: AppEnvironment.dev,
          baseUrl: 'http://localhost:8080',
          enableLogs: true,
        );
        break;
      case AppEnvironment.staging:
        instance = const Environment(
          environment: AppEnvironment.staging,
          baseUrl: 'http://localhost:8080',
          enableLogs: true,
        );
        break;
      case AppEnvironment.prod:
        instance = const Environment(
          environment: AppEnvironment.prod,
          baseUrl: 'http://localhost:8080',
          enableLogs: false,
        );
        break;
    }
  }
}
