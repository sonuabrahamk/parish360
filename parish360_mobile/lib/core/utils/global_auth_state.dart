/// Global auth state helpers used when Riverpod `Ref` is unavailable.
class GlobalAuthState {
  GlobalAuthState._();

  /// When true, router should force navigation to the login screen.
  static bool forceLoggedOut = false;
}
