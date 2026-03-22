import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:parish360_mobile/core/app/app_shell.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:parish360_mobile/features/families/presentation/pages/family_info_list_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/family_record_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authControllerProvider);

  return GoRouter(
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isLoggedIn = auth.value?.accessToken.isNotEmpty == true;

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/dashboard';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const Center(child: Text('Dashboard')),
          ),
          GoRoute(
            path: '/families',
            name: 'families',
            builder: (context, state) => FamilyInfoListScreen(),
          ),
          GoRoute(
            path: '/families/:familyId',
            name: 'Family Record',
            builder: (context, state) {
              final familyId = state.pathParameters['familyId']!;
              return FamilyRecordScreen(familyId: familyId);
            },
          ),
        ],
      ),
    ],
  );
});
