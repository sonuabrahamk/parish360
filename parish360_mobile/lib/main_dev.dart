import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/application_environment.dart';
import 'core/config/environment_configuration.dart';
import 'package:flutter/material.dart';

void main() {
  EnvironmentConfiguration.init(AppEnvironment.dev);
  runApp(
    const ProviderScope(
      child: MyApp()
    ),
  );
}
