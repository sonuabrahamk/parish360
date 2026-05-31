import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/features/auth/presentation/pages/login_page.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void popAllAndPush(String routeName) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    // Prefer GoRouter navigation; fall back to Navigator if GoRouter
    // is not available in the current context yet.
    try {
      GoRouter.of(ctx).go(routeName);
    } catch (_) {
      // Fallback: push the actual LoginScreen and remove all previous routes.
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}
