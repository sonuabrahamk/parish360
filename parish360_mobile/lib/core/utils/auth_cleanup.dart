import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/app/app_navigator.dart';
import 'package:parish360_mobile/core/network/cookie_store.dart';
import 'package:parish360_mobile/core/utils/global_auth_state.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';

/// Centralized cleanup for authentication state and persisted resources.
///
/// If a `ref` is provided and mounted, the Riverpod logout path will be used
/// to correctly invalidate providers. If not, the function falls back to
/// clearing cookies via `CookieStore.cookieJar` and performs global
/// navigation to the login screen.
Future<void> performAuthCleanup({Ref? ref}) async {
  // Try the Riverpod logout path when possible
  try {
    if (ref != null && ref.mounted) {
      await ref.read(authControllerProvider.notifier).logout();
      AppNavigator.popAllAndPush('/login');
      return;
    }
  } catch (_) {
    // ignore and fall back
  }

  // Fallback: clear cookies and navigate to login.
  try {
    await CookieStore.cookieJar?.deleteAll();
    // mark global flag so router redirects to login even if providers
    // still report an authenticated state (we couldn't update providers).
    GlobalAuthState.forceLoggedOut = true;
  } catch (_) {
    // ignore errors from cookie clearing
  }

  AppNavigator.popAllAndPush('/login');
}
