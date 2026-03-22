import 'package:parish360_mobile/core/config/application_environment.dart';

class Environment {
  final AppEnvironment environment;
  final String baseUrl;
  final bool enableLogs;

  const Environment({
    required this.environment,
    required this.baseUrl,
    required this.enableLogs,
  });
}
