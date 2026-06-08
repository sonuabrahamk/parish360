import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:parish360_mobile/core/app/app_shell.dart';
import 'package:parish360_mobile/features/associations/presentation/pages/parish_year_associations_screen.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/core/utils/global_auth_state.dart';
import 'package:parish360_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:parish360_mobile/features/bookings/presentation/pages/bookings_screen.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/pages/ceremonies_screen.dart';
import 'package:parish360_mobile/features/configurations/presentation/pages/configurations_screen.dart';
import 'package:parish360_mobile/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:parish360_mobile/features/expenses/presentation/pages/expenses_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/family_info_list_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/family_info_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/family_record_screen.dart';
import 'package:parish360_mobile/features/parish-year/presentation/pages/parish_year_list_screen.dart';
import 'package:parish360_mobile/features/payments/presentation/pages/payments_screen.dart';
import 'package:parish360_mobile/features/users/presentation/pages/users_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: AppNavigator.navigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final authState = ref.watch(authControllerProvider);
      final isLoggedIn = authState.maybeWhen(
        data: (loginResponse) => loginResponse.accessToken.isNotEmpty,
        orElse: () => false,
      );

      // If a global forced-logout was requested (fallback path), route to login.
      if (GlobalAuthState.forceLoggedOut) {
        return '/login';
      }

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
            builder: (context, state) => DashboardScreen(),
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
              if (familyId == 'new') {
                return FamilyInfoScreen(familyId: familyId, isEditing: true);
              }
              return FamilyRecordScreen(familyId: familyId);
            },
          ),
          GoRoute(
            path: '/configurations',
            name: 'Configurations',
            builder: (context, state) => const ConfigurationsScreen(),
          ),
          GoRoute(
            path: '/bookings',
            name: 'Bookings',
            builder: (context, state) => const BookingsScreen(),
          ),
          GoRoute(
            path: '/ceremonies',
            name: 'Ceremonies',
            builder: (context, state) => const CeremoniesScreen(),
          ),
          GoRoute(
            path: '/expenses',
            name: 'Expenses',
            builder: (context, state) => const ExpensesScreen(),
          ),
          GoRoute(
            path: '/payments',
            name: 'Payments',
            builder: (context, state) => const PaymentsScreen(),
          ),
          GoRoute(
            path: '/users',
            name: 'Users',
            builder: (context, state) => const UsersScreen(),
          ),
          GoRoute(
            path: '/parish-year',
            name: 'Parish Year',
            builder: (context, state) => const ParishYearListScreen(),
          ),
          GoRoute(
            path: '/associations',
            name: 'Associations',
            builder: (context, state) => const ParishYearAssociationsScreen(),
          ),
        ],
      ),
    ],
  );
});
